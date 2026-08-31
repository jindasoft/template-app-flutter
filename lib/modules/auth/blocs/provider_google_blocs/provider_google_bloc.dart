import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../repositories/provider_google_repository.dart';
import 'provider_google_event.dart';
import 'provider_google_state.dart';

class ProviderGoogleBloc
    extends Bloc<ProviderGoogleEvent, ProviderGoogleState> {
  final ProviderGoogleRepository repository;

  ProviderGoogleBloc(this.repository) : super(ProviderGoogleInitial()) {
    on<GoogleSignInRequested>(
      _onGoogleSignInRequested,
      transformer: droppable(),
    );
  }

  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<ProviderGoogleState> emit,
  ) async {
    final previousUser = state.userFirebase;
    emit(GoogleSignInLoading(previousUser));
    try {
      final signedInUser = await repository.signInWithGoogle();
      emit(GoogleSignInSuccess(signedInUser));
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        emit(GoogleSignInCanceled(previousUser));
      } else {
        emit(GoogleSignInFailure('error.request_failed', previousUser));
      }
    } catch (e) {
      emit(GoogleSignInFailure('error.unexpected', previousUser));
    }
  }
}
