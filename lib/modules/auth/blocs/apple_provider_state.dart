import 'package:equatable/equatable.dart';

import '../models/user_firebase.dart';

abstract class AppleProviderState extends Equatable {
  final UserFirebase userFirebase;

  const AppleProviderState(this.userFirebase);

  @override
  List<Object?> get props => [userFirebase];
}

class AppleProviderInitial extends AppleProviderState {
  const AppleProviderInitial() : super(const UserFirebase.empty());
}

class AppleSignInLoading extends AppleProviderState {
  const AppleSignInLoading(super.userFirebase);
}

class AppleSignInSuccess extends AppleProviderState {
  const AppleSignInSuccess(super.userFirebase);
}

class AppleSignInFailure extends AppleProviderState {
  final String error;
  const AppleSignInFailure(this.error, super.userFirebase);

  @override
  List<Object?> get props => [error, userFirebase];
}

class AppleSignOutLoading extends AppleProviderState {
  const AppleSignOutLoading(super.userFirebase);
}

class AppleSignOutSuccess extends AppleProviderState {
  const AppleSignOutSuccess() : super(const UserFirebase.empty());
}

class AppleSignOutFailure extends AppleProviderState {
  final String error;
  const AppleSignOutFailure(this.error, super.userFirebase);

  @override
  List<Object?> get props => [error, userFirebase];
}
