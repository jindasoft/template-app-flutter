import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/provider_google_repository.dart';
import 'google_provider_event.dart';
import 'google_provider_state.dart';

class GoogleProviderBloc
    extends Bloc<GoogleProviderEvent, GoogleProviderState> {
  final ProviderGoogleRepository repository;

  GoogleProviderBloc(this.repository) : super(GoogleProviderInitial()) {
    on<GoogleSignInRequested>(
      _onGoogleSignInRequested,
      transformer: droppable(),
    );
    on<GoogleSignOutRequested>(
      _onGoogleSignOutRequested,
      transformer: droppable(),
    );
  }

  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<GoogleProviderState> emit,
  ) async {
    final previousUser = state.userFirebase;
    emit(GoogleSignInLoading(previousUser));
    try {
      final signedInUser = await repository.signInWithGoogle();
      emit(GoogleSignInSuccess(signedInUser));
    } catch (e) {
      emit(GoogleSignInFailure(e.toString(), previousUser));
    }
  }

  Future<void> _onGoogleSignOutRequested(
    GoogleSignOutRequested event,
    Emitter<GoogleProviderState> emit,
  ) async {
    final previousUser = state.userFirebase;
    emit(GoogleSignOutLoading(previousUser));
    try {
      await repository.signOut();
      emit(GoogleSignOutSuccess());
    } catch (e) {
      emit(GoogleSignOutFailure(e.toString(), previousUser));
    }
  }
}
