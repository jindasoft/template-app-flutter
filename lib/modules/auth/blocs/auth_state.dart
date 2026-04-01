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

class AuthLoading extends AuthState {
  const AuthLoading(super.token);
}

class AuthSuccess extends AuthState {
  const AuthSuccess(super.token);
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error, super.authorize);

  @override
  List<Object?> get props => [error, token];
}

class AuthSignOutLoading extends AuthState {
  const AuthSignOutLoading(super.token);
}

class AuthSignOutSuccess extends AuthState {
  const AuthSignOutSuccess(super.token);
}

class AuthRemoveLoading extends AuthState {
  const AuthRemoveLoading(super.token);
}

class AuthRemoveSuccess extends AuthState {
  const AuthRemoveSuccess(super.token);
}
