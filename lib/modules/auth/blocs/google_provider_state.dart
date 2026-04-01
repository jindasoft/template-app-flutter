import 'package:equatable/equatable.dart';

import '../models/user_firebase.dart';

abstract class GoogleProviderState extends Equatable {
  final UserFirebase userFirebase;

  const GoogleProviderState(this.userFirebase);

  @override
  List<Object?> get props => [userFirebase];
}

class GoogleProviderInitial extends GoogleProviderState {
  GoogleProviderInitial() : super(UserFirebase.empty());
}

class GoogleSignInLoading extends GoogleProviderState {
  const GoogleSignInLoading(super.userFirebase);
}

class GoogleSignInSuccess extends GoogleProviderState {
  const GoogleSignInSuccess(super.userFirebase);
}

class GoogleProviderFailure extends GoogleProviderState {
  final String error;
  const GoogleProviderFailure(this.error, userFirebase) : super(userFirebase);

  @override
  List<Object?> get props => [error, userFirebase];
}

class GoogleSignOutLoading extends GoogleProviderState {
  const GoogleSignOutLoading(super.userFirebase);
}

class GoogleSignOutSuccess extends GoogleProviderState {
  GoogleSignOutSuccess() : super(UserFirebase.empty());
}
