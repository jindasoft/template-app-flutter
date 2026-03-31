import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_firebase.dart';
import '../repositories/google_provider_repository.dart';
import 'google_provider_event.dart';
import 'google_provider_state.dart';

class GoogleProviderBloc
    extends Bloc<GoogleProviderEvent, GoogleProviderState> {
  final GoogleProviderRepository repository;
  final UserFirebase userFirebase = UserFirebase.empty();

  GoogleProviderBloc(this.repository) : super(GoogleProviderInitial()) {
    on<GoogleSignInRequested>((event, emit) async {
      emit(GoogleSignInLoading(userFirebase));
      try {
        final userFirebase = await repository.signInWithGoogle();
        emit(GoogleSignInSuccess(userFirebase));
      } catch (e) {
        emit(GoogleProviderFailure(e.toString(), userFirebase));
      }
    });

    on<GoogleSignOutRequested>((event, emit) async {
      emit(GoogleSignOutLoading(userFirebase));
      await repository.signOut();
      emit(GoogleSignOutSuccess());
    });
  }
}
