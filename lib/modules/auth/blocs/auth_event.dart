import '../models/user_firebase.dart';

abstract class AuthEvent {}

class AuthSignInRequested extends AuthEvent {
  final UserFirebase userFirebase;

  AuthSignInRequested(this.userFirebase);
}

class AuthSignOutRequested extends AuthEvent {}

class AuthStatusLoaded extends AuthEvent {}

class AuthRemoveRequested extends AuthEvent {}
