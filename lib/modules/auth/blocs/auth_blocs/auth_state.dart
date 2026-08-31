import 'package:equatable/equatable.dart';

import '../../models/token_response.dart';

abstract class AuthState extends Equatable {
  final TokenResponse token;

  const AuthState(this.token);

  @override
  List<Object?> get props => [token];
}

class AuthInitial extends AuthState {
  const AuthInitial(super.token);
}

class SignInLoading extends AuthState {
  const SignInLoading(super.token);
}

class SignInSuccess extends AuthState {
  const SignInSuccess(super.token);
}

class SignInFailure extends AuthState {
  final String error;

  const SignInFailure(this.error, super.token);

  @override
  List<Object?> get props => [error, token];
}

class SignOutLoading extends AuthState {
  const SignOutLoading(super.token);
}

class SignOutSuccess extends AuthState {
  const SignOutSuccess(super.token);
}

class SignOutFailure extends AuthState {
  final String error;

  const SignOutFailure(this.error, super.token);

  @override
  List<Object?> get props => [error, token];
}

class DeleteAccountLoading extends AuthState {
  const DeleteAccountLoading(super.token);
}

class DeleteAccountSuccess extends AuthState {
  const DeleteAccountSuccess(super.token);
}

class DeleteAccountFailure extends AuthState {
  final String error;

  const DeleteAccountFailure(this.error, super.token);

  @override
  List<Object?> get props => [error, token];
}
