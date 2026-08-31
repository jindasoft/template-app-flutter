import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../repositories/provider_apple_repository.dart';
import 'provider_apple_event.dart';
import 'provider_apple_state.dart';

class ProviderAppleBloc extends Bloc<ProviderAppleEvent, ProviderAppleState> {
  final ProviderAppleRepository repository;

  ProviderAppleBloc(this.repository) : super(const ProviderAppleInitial()) {
    on<AppleSignInRequested>(_onAppleSignInRequested, transformer: droppable());
  }

  Future<void> _onAppleSignInRequested(
    AppleSignInRequested event,
    Emitter<ProviderAppleState> emit,
  ) async {
    final previousUser = state.userFirebase;
    emit(AppleSignInLoading(previousUser));
    try {
      final signedInUser = await repository.signInWithApple();
      emit(AppleSignInSuccess(signedInUser));
    } on SignInWithAppleAuthorizationException catch (e) {
      if (_isCanceledOrClosedByUser(e)) {
        emit(AppleSignInCanceled(previousUser));
      } else {
        emit(AppleSignInFailure('error.request_failed', previousUser));
      }
    } catch (e) {
      emit(AppleSignInFailure('error.unexpected', previousUser));
    }
  }

  bool _isCanceledOrClosedByUser(SignInWithAppleAuthorizationException e) {
    if (e.code == AuthorizationErrorCode.canceled) {
      return true;
    }

    // Some iOS flows report closing the Apple sheet as "unknown" with
    // ASAuthorizationError 1000. Treat it as a user-dismissed action.
    final raw = e.toString().toLowerCase();
    return e.code == AuthorizationErrorCode.unknown &&
        raw.contains('authenticationservices.authorizationerror') &&
        raw.contains('error 1000');
  }
}
