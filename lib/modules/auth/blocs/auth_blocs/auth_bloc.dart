import 'dart:async';

import 'package:template_app_flutter/core/services/app_logger.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/authorize_request.dart';
import '../../models/delete_account_request.dart';
import '../../models/sign_out_request.dart';
import '../../models/token_response.dart';
import '../../models/token_request.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/provider_apple_repository.dart';
import '../../repositories/provider_google_repository.dart';
import '../../services/device_service.dart';
import '../../services/pkce_service.dart';
import '../../services/provider_resolver.dart';
import '../../services/token_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final logger = AppLogger.instance;
  final AuthRepository authRepository;
  final ProviderGoogleRepository _providerGoogleRepository =
      ProviderGoogleRepository();
  final ProviderAppleRepository _providerAppleRepository =
      ProviderAppleRepository();
  final Completer<void> _initCompleter = Completer<void>();
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  Future<void> get initialized => _initCompleter.future;

  AuthBloc(this.authRepository)
    : super(const AuthInitial(TokenResponse.empty())) {
    _initSignInStatus();

    on<SignInRequested>(_onSignInRequested, transformer: droppable());
    on<SignOutRequested>(_onSignOutRequested, transformer: droppable());
    on<DeleteAccountRequested>(
      _onDeleteAccountRequested,
      transformer: droppable(),
    );
    on<AuthStatusLoaded>(_onAuthStatusLoaded);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    final previousToken = state.token;
    emit(SignInLoading(previousToken));
    try {
      final verifierCode = PkceService.getVerifierCode();
      final challengeCode = PkceService.getChallengeCode(verifierCode);

      final userFirebase = event.userFirebase;
      final authRequest = AuthorizeRequest(
        firebaseUid: userFirebase.uid,
        email: userFirebase.email,
        displayName: userFirebase.displayName ?? "-",
        provider: userFirebase.provider,
        challengeCode: challengeCode,
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

      await _setSignIn();

      emit(SignInSuccess(token));
    } catch (e) {
      emit(SignInFailure('error.request_failed', previousToken));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    final previousToken = state.token;
    emit(SignOutLoading(previousToken));
    try {
      final signOutRequest = SignOutRequest(
        refreshToken: await TokenService.getRefreshToken(),
      );
      await authRepository.postSignOut(signOutRequest);
      await _setSignOut();
      await _signOutProviders();

      emit(const SignOutSuccess(TokenResponse.empty()));
    } catch (e) {
      emit(SignOutFailure('error.unexpected', previousToken));
    }
  }

  Future<void> _onDeleteAccountRequested(
    DeleteAccountRequested event,
    Emitter<AuthState> emit,
  ) async {
    final previousToken = state.token;
    emit(DeleteAccountLoading(previousToken));
    try {
      final deleteAccountRequest = DeleteAccountRequest(
        refreshToken: await TokenService.getRefreshToken(),
      );
      await authRepository.deleteAccount(deleteAccountRequest);
      // Backend account is gone at this point — clear local session unconditionally,
      // provider cleanup below is best-effort and must not block or fail this flow.
      await _setSignOut();
      await _deleteProviderAccount();

      emit(const DeleteAccountSuccess(TokenResponse.empty()));
    } catch (e) {
      emit(DeleteAccountFailure('error.unexpected', previousToken));
    }
  }

  Future<void> _deleteProviderAccount() async {
    try {
      await getProviderRepository().deleteAccount();
    } catch (e) {
      logger.e('Provider account deletion failed');
    }
  }

  void _onAuthStatusLoaded(AuthStatusLoaded event, Emitter<AuthState> emit) {
    emit(AuthInitial(state.token));
  }

  // Best-effort: clear provider sessions but don't block local/backend sign-out on failure.
  Future<void> _signOutProviders() async {
    try {
      await _providerGoogleRepository.signOut();
    } catch (e) {
      logger.e('Google provider sign out failed');
    }
    try {
      await _providerAppleRepository.signOut();
    } catch (e) {
      logger.e('Apple provider sign out failed');
    }
  }

  Future<void> _initSignInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isSignedIn = prefs.getBool('signed_in') ?? false;

    add(const AuthStatusLoaded());
    if (!_initCompleter.isCompleted) {
      _initCompleter.complete();
    }
  }

  Future<void> _setSignIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('signed_in', true);
    _isSignedIn = true;
  }

  Future<void> _setSignOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await TokenService.clearSession();
    await DeviceService.clearSession();
    await prefs.setBool('signed_in', false);
    _isSignedIn = false;
  }
}
