import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/provider_apple_repository.dart';
import 'apple_provider_event.dart';
import 'apple_provider_state.dart';

class AppleProviderBloc extends Bloc<AppleProviderEvent, AppleProviderState> {
  final ProviderAppleRepository repository;

  AppleProviderBloc(this.repository) : super(const AppleProviderInitial()) {
    on<AppleSignInRequested>(_onAppleSignInRequested, transformer: droppable());
    on<AppleSignOutRequested>(
      _onAppleSignOutRequested,
      transformer: droppable(),
    );
  }

  Future<void> _onAppleSignInRequested(
    AppleSignInRequested event,
    Emitter<AppleProviderState> emit,
  ) async {
    final previousUser = state.userFirebase;
    emit(AppleSignInLoading(previousUser));
    try {
      final signedInUser = await repository.signInWithApple();
      emit(AppleSignInSuccess(signedInUser));
    } catch (e) {
      emit(AppleSignInFailure(e.toString(), previousUser));
    }
  }

  Future<void> _onAppleSignOutRequested(
    AppleSignOutRequested event,
    Emitter<AppleProviderState> emit,
  ) async {
    final previousUser = state.userFirebase;
    emit(AppleSignOutLoading(previousUser));
    try {
      await repository.signOut();
      emit(const AppleSignOutSuccess());
    } catch (e) {
      emit(AppleSignOutFailure(e.toString(), previousUser));
    }
  }
}
