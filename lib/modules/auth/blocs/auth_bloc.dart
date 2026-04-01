import 'dart:async';

import 'package:template_app_flutter/configs/app_config.dart';
import 'package:template_app_flutter/core/services/app_logger.dart';
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

  AuthBloc(this.authRepository) : super(AuthInitial(Token.empty())) {
    _initSignInStatus();

    on<AuthSignInRequested>((event, emit) async {
      emit(AuthLoading(Token.empty()));
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

        // Save the access token to secure storage
        TokenService.saveAccessToken(token.accessToken);
        TokenService.saveRefreshToken(token.refreshToken);
        TokenService.saveVerifierCode(verifierCode);

        await setSignIn();

        emit(AuthSuccess(token));
      } catch (e) {
        emit(AuthFailure(e.toString(), Token.empty()));
      }
    });

    on<AuthSignOutRequested>((event, emit) async {
      emit(AuthSignOutLoading(Token.empty()));
      try {
        TokenService.deleteAccessToken();
        TokenService.deleteRefreshToken();
        TokenService.deleteVerifierCode();

        await setSignOut();

        emit(AuthSignOutSuccess(Token.empty()));
      } catch (e) {
        emit(AuthFailure(e.toString(), Token.empty()));
      }
    });

    on<AuthRemoveRequested>((event, emit) async {
      emit(AuthRemoveLoading(Token.empty()));
      try {
        TokenService.deleteAccessToken();
        TokenService.deleteRefreshToken();
        TokenService.deleteVerifierCode();

        await setSignOut();

        emit(AuthRemoveSuccess(Token.empty()));
      } catch (e) {
        emit(AuthFailure(e.toString(), Token.empty()));
      }
    });

    on<AuthStatusLoaded>((event, emit) {
      emit(AuthInitial(Token.empty()));
    });
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

    add(AuthStatusLoaded());
    if (!_initCompleter.isCompleted) {
      _initCompleter.complete();
    }
  }

  Future setSignIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('signed_in', true);
    _isSignedIn = true;
  }

  Future setSignOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('signed_in', false);
    _isSignedIn = false;
  }
}
