import 'package:equatable/equatable.dart';

sealed class ProviderGoogleEvent extends Equatable {
  const ProviderGoogleEvent();

  @override
  List<Object?> get props => [];
}

class GoogleSignInRequested extends ProviderGoogleEvent {
  const GoogleSignInRequested();
}
