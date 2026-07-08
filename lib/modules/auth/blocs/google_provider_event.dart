import 'package:equatable/equatable.dart';

sealed class GoogleProviderEvent extends Equatable {
  const GoogleProviderEvent();

  @override
  List<Object?> get props => [];
}

class GoogleSignInRequested extends GoogleProviderEvent {
  const GoogleSignInRequested();
}

class GoogleSignOutRequested extends GoogleProviderEvent {
  const GoogleSignOutRequested();
}
