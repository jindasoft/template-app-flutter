import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_firebase.dart';
import '../repositories/provider_repository.dart';
import 'firebase_event.dart';
import 'firebase_state.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  final ProviderRepository providerRepository;
  bool _isRemovingAccount = false;

  FirebaseBloc(this.providerRepository)
    : super(const FirebaseInitial(UserFirebase.empty())) {
    on<FirebaseAccountRemoveRequested>(
      _onFirebaseAccountRemoveRequested,
      transformer: droppable(),
    );
  }

  Future<void> _onFirebaseAccountRemoveRequested(
    FirebaseAccountRemoveRequested event,
    Emitter<FirebaseState> emit,
  ) async {
    if (_isRemovingAccount) {
      return;
    }
    _isRemovingAccount = true;
    final previousUser = state.userFirebase;

    emit(FirebaseAccountRemoving(previousUser));
    try {
      await providerRepository.removeAccount();
      emit(const FirebaseAccountRemoveSuccess());
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        // User canceled — silently return to initial state
        emit(FirebaseInitial(previousUser));
      } else {
        emit(FirebaseAccountRemoveFailure(e.toString(), previousUser));
      }
    } catch (e) {
      emit(FirebaseAccountRemoveFailure(e.toString(), previousUser));
    } finally {
      _isRemovingAccount = false;
    }
  }
}
