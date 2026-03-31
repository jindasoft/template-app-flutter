import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_firebase.dart';
import '../repositories/apple_provider_repository.dart';
import 'apple_provider_event.dart';
import 'apple_provider_state.dart';

class AppleProviderBloc extends Bloc<AppleProviderEvent, AppleProviderState> {
  final AppleProviderRepository repository;
  final UserFirebase userFirebase = UserFirebase.empty();

  AppleProviderBloc(this.repository) : super(AppleProviderInitial()) {
    on<AppleSignInRequested>((event, emit) async {
      emit(AppleSignInLoading(userFirebase));
      try {
        final userFirebase = await repository.signInWithApple();
        emit(AppleSignInSuccess(userFirebase));
      } catch (e) {
        emit(AppleProviderFailure(e.toString(), userFirebase));
      }
    });

    on<AppleSignOutRequested>((event, emit) async {
      emit(AppleSignOutLoading(userFirebase));
      await repository.signOut();
      emit(AppleSignOutSuccess());
    });
  }
}
