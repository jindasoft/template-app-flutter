import 'package:equatable/equatable.dart';

import '../../models/user_firebase.dart';

abstract class ProviderAppleState extends Equatable {
  final UserFirebase userFirebase;

  const ProviderAppleState(this.userFirebase);

  @override
  List<Object?> get props => [userFirebase];
}

class ProviderAppleInitial extends ProviderAppleState {
  const ProviderAppleInitial() : super(const UserFirebase.empty());
}

class AppleSignInLoading extends ProviderAppleState {
  const AppleSignInLoading(super.userFirebase);
}

class AppleSignInSuccess extends ProviderAppleState {
  const AppleSignInSuccess(super.userFirebase);
}

class AppleSignInCanceled extends ProviderAppleState {
  const AppleSignInCanceled(super.userFirebase);
}

class AppleSignInFailure extends ProviderAppleState {
  final String error;
  const AppleSignInFailure(this.error, super.userFirebase);

  @override
  List<Object?> get props => [error, userFirebase];
}
