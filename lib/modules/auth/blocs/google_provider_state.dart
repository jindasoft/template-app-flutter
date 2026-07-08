import 'package:equatable/equatable.dart';

import '../models/user_firebase.dart';

abstract class GoogleProviderState extends Equatable {
  final UserFirebase userFirebase;

  const GoogleProviderState(this.userFirebase);

  @override
  List<Object?> get props => [userFirebase];
}

class GoogleProviderInitial extends GoogleProviderState {
  const GoogleProviderInitial() : super(const UserFirebase.empty());
}

class GoogleSignInLoading extends GoogleProviderState {
  const GoogleSignInLoading(super.userFirebase);
}

class GoogleSignInSuccess extends GoogleProviderState {
  const GoogleSignInSuccess(super.userFirebase);
}

class GoogleSignInFailure extends GoogleProviderState {
  final String error;
  const GoogleSignInFailure(this.error, super.userFirebase);

  @override
  List<Object?> get props => [error, userFirebase];
}

class GoogleSignOutLoading extends GoogleProviderState {
  const GoogleSignOutLoading(super.userFirebase);
}

class GoogleSignOutSuccess extends GoogleProviderState {
  const GoogleSignOutSuccess() : super(const UserFirebase.empty());
}

class GoogleSignOutFailure extends GoogleProviderState {
  final String error;
  const GoogleSignOutFailure(this.error, super.userFirebase);

  @override
  List<Object?> get props => [error, userFirebase];
}
