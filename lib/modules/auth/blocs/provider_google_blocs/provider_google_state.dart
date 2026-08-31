import 'package:equatable/equatable.dart';

import '../../models/user_firebase.dart';

abstract class ProviderGoogleState extends Equatable {
  final UserFirebase userFirebase;

  const ProviderGoogleState(this.userFirebase);

  @override
  List<Object?> get props => [userFirebase];
}

class ProviderGoogleInitial extends ProviderGoogleState {
  const ProviderGoogleInitial() : super(const UserFirebase.empty());
}

class GoogleSignInLoading extends ProviderGoogleState {
  const GoogleSignInLoading(super.userFirebase);
}

class GoogleSignInSuccess extends ProviderGoogleState {
  const GoogleSignInSuccess(super.userFirebase);
}

class GoogleSignInCanceled extends ProviderGoogleState {
  const GoogleSignInCanceled(super.userFirebase);
}

class GoogleSignInFailure extends ProviderGoogleState {
  final String error;
  const GoogleSignInFailure(this.error, super.userFirebase);

  @override
  List<Object?> get props => [error, userFirebase];
}
