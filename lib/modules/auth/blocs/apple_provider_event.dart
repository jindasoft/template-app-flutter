import 'package:equatable/equatable.dart';

sealed class AppleProviderEvent extends Equatable {
  const AppleProviderEvent();

  @override
  List<Object?> get props => [];
}

class AppleSignInRequested extends AppleProviderEvent {
  const AppleSignInRequested();
}

class AppleSignOutRequested extends AppleProviderEvent {
  const AppleSignOutRequested();
}
