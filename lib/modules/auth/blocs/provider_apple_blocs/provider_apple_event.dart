import 'package:equatable/equatable.dart';

sealed class ProviderAppleEvent extends Equatable {
  const ProviderAppleEvent();

  @override
  List<Object?> get props => [];
}

class AppleSignInRequested extends ProviderAppleEvent {
  const AppleSignInRequested();
}
