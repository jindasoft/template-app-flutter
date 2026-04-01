import 'package:equatable/equatable.dart';

import '../models/user_firebase.dart';

abstract class AppleProviderState extends Equatable {
  final UserFirebase userFirebase;

  const AppleProviderState(this.userFirebase);

  @override
  List<Object?> get props => [userFirebase];
}

class AppleProviderInitial extends AppleProviderState {
  AppleProviderInitial() : super(UserFirebase.empty());
}

class AppleProviderFailure extends AppleProviderState {
  final String error;
  const AppleProviderFailure(this.error, userFirebase) : super(userFirebase);

  @override
  List<Object?> get props => [error, userFirebase];
}

class AppleSignInLoading extends AppleProviderState {
  const AppleSignInLoading(super.userFirebase);
}

class AppleSignInSuccess extends AppleProviderState {
  const AppleSignInSuccess(super.userFirebase);
}

class AppleSignOutLoading extends AppleProviderState {
  const AppleSignOutLoading(super.userFirebase);
}

class AppleSignOutSuccess extends AppleProviderState {
  AppleSignOutSuccess() : super(UserFirebase.empty());
}
