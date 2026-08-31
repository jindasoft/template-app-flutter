import 'package:equatable/equatable.dart';

import '../../models/user_firebase.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthEvent {
  final UserFirebase userFirebase;

  const SignInRequested(this.userFirebase);

  @override
  List<Object?> get props => [userFirebase];
}

class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}

class DeleteAccountRequested extends AuthEvent {
  const DeleteAccountRequested();
}

class AuthStatusLoaded extends AuthEvent {
  const AuthStatusLoaded();
}
