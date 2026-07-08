import 'package:equatable/equatable.dart';

sealed class FirebaseEvent extends Equatable {
  const FirebaseEvent();

  @override
  List<Object?> get props => [];
}

class FirebaseAccountRemoveRequested extends FirebaseEvent {
  const FirebaseAccountRemoveRequested();
}
