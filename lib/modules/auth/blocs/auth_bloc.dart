import 'dart:async';

import 'package:template_app_flutter/configs/app_config.dart';
import 'package:template_app_flutter/core/services/app_logger.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/authorize_request.dart';
import '../models/token.dart';
import '../models/token_request.dart';
import '../repositories/auth_repository.dart';
import '../services/pkce_service.dart';
import '../services/token_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final logger = AppLogger.instance;
  final AuthRepository authRepository;
  final Completer<void> _initCompleter = Completer<void>();
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  Future<void> get initialized => _initCompleter.future;

  AuthBloc(this.authRepository) : super(const AuthInitial(Token.empty())) {
    _initSignInStatus();

    on<AuthSignInRequested>(_onAuthSignInRequested, transformer: droppable());
    on<AuthSignOutRequested>(_onAuthSignOutRequested, transformer: droppable());
    on<AuthRemoveRequested>(_onAuthRemoveRequested, transformer: droppable());
    on<AuthStatusLoaded>(_onAuthStatusLoaded);
  }

  Future<void> _onAuthSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    final previousToken = state.token;
    emit(AuthSignInLoading(previousToken));
    try {
      final verifierCode = PkceService().generateCodeVerifier();
      final challengeCode = PkceService().generateCodeChallenge(verifierCode);

      final userFirebase = event.userFirebase;
      final authRequest = AuthorizeRequest(
        firebaseUid: userFirebase.uid,
        email: userFirebase.email,
        name: userFirebase.displayName ?? "-",
        provider: userFirebase.provider,
        challengeCode: challengeCode,
        userSource: AppConfig.userSource,
      );

      final authorize = await authRepository.postAuthorize(
        authRequest,
        userFirebase.idToken,
      );

      final tokenRequest = TokenRequest(
        authorizeToken: authorize.authorizeToken,
        verifierCode: verifierCode,
      );
      final token = await authRepository.postToken(tokenRequest);

      // Persist session tokens for subsequent authenticated requests.
      await TokenService.saveAccessToken(token.accessToken);
      await TokenService.saveRefreshToken(token.refreshToken);
      await TokenService.saveVerifierCode(verifierCode);

      await setSignIn();

      emit(AuthSignInSuccess(token));
    } catch (e) {
      emit(AuthSignInFailure(e.toString(), previousToken));
    }
  }

  Future<void> _onAuthSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    final previousToken = state.token;
    emit(AuthSignOutLoading(previousToken));
    try {
      await TokenService.deleteAccessToken();
      await TokenService.deleteRefreshToken();
      await TokenService.deleteVerifierCode();

      await setSignOut();

      emit(const AuthSignOutSuccess(Token.empty()));
    } catch (e) {
      emit(AuthSignOutFailure(e.toString(), previousToken));
    }
  }

  Future<void> _onAuthRemoveRequested(
    AuthRemoveRequested event,
    Emitter<AuthState> emit,
  ) async {
    final previousToken = state.token;
    emit(AuthRemoveLoading(previousToken));
    try {
      await TokenService.deleteAccessToken();
      await TokenService.deleteRefreshToken();
      await TokenService.deleteVerifierCode();

      await setSignOut();

      emit(const AuthRemoveSuccess(Token.empty()));
    } catch (e) {
      emit(AuthRemoveFailure(e.toString(), previousToken));
    }
  }

  void _onAuthStatusLoaded(AuthStatusLoaded event, Emitter<AuthState> emit) {
    emit(AuthInitial(state.token));
  }

  Future<void> _initSignInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final localSignedIn = prefs.getBool('signed_in') ?? false;
    final accessToken = await TokenService.getAccessToken();
    final hasToken = accessToken != null && accessToken.isNotEmpty;

    _isSignedIn = localSignedIn && hasToken;
    if (_isSignedIn != localSignedIn) {
      await prefs.setBool('signed_in', _isSignedIn);
    }

    add(const AuthStatusLoaded());
    if (!_initCompleter.isCompleted) {
      _initCompleter.complete();
    }
  }

  Future<void> setSignIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('signed_in', true);
    _isSignedIn = true;
  }

  Future<void> setSignOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('signed_in', false);
    _isSignedIn = false;
  }
}
