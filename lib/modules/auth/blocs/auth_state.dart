import 'package:equatable/equatable.dart';

import '../models/token.dart';

abstract class AuthState extends Equatable {
  final Token token;

  const AuthState(this.token);

  @override
  List<Object?> get props => [token];
}

class AuthInitial extends AuthState {
  const AuthInitial(super.token);
}

class AuthSignInLoading extends AuthState {
  const AuthSignInLoading(super.token);
}

class AuthSignInSuccess extends AuthState {
  const AuthSignInSuccess(super.token);
}

class AuthSignInFailure extends AuthState {
  final String error;

  const AuthSignInFailure(this.error, super.token);

  @override
  List<Object?> get props => [error, token];
}

class AuthSignOutLoading extends AuthState {
  const AuthSignOutLoading(super.token);
}

class AuthSignOutFailure extends AuthState {
  final String error;

  const AuthSignOutFailure(this.error, super.token);

  @override
  List<Object?> get props => [error, token];
}

class AuthSignOutSuccess extends AuthState {
  const AuthSignOutSuccess(super.token);
}

class AuthRemoveLoading extends AuthState {
  const AuthRemoveLoading(super.token);
}

class AuthRemoveFailure extends AuthState {
  final String error;

  const AuthRemoveFailure(this.error, super.token);

  @override
  List<Object?> get props => [error, token];
}

class AuthRemoveSuccess extends AuthState {
  const AuthRemoveSuccess(super.token);
}
