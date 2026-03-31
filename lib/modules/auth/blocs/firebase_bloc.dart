import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_firebase.dart';
import '../repositories/provider_repository.dart';
import 'firebase_event.dart';
import 'firebase_state.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  final ProviderRepository providerRepository;
  final UserFirebase userFirebase = UserFirebase.empty();
  bool _isRemovingAccount = false;

  FirebaseBloc(this.providerRepository) : super(FirebaseInitial()) {
    on<FirebaseAccountRemoveRequested>((event, emit) async {
      if (_isRemovingAccount) {
        return;
      }
      _isRemovingAccount = true;

      emit(FirebaseAccountRemoving(userFirebase));
      try {
        await providerRepository.removeAccount();
        emit(FirebaseAccountRemoved());
      } on GoogleSignInException catch (e) {
        if (e.code == GoogleSignInExceptionCode.canceled) {
          // User canceled — silently return to initial state
          emit(FirebaseInitial());
        } else {
          emit(FirebaseFailure(e.toString(), userFirebase));
        }
      } catch (e) {
        emit(FirebaseFailure(e.toString(), userFirebase));
      } finally {
        _isRemovingAccount = false;
      }
    });
  }
}
