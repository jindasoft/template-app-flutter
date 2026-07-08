import 'package:equatable/equatable.dart';

import '../models/user_firebase.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthSignInRequested extends AuthEvent {
  final UserFirebase userFirebase;

  const AuthSignInRequested(this.userFirebase);

  @override
  List<Object?> get props => [userFirebase];
}

class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}

class AuthStatusLoaded extends AuthEvent {
  const AuthStatusLoaded();
}

class AuthRemoveRequested extends AuthEvent {
  const AuthRemoveRequested();
}
