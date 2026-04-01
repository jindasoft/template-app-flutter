import 'package:equatable/equatable.dart';

import '../models/user_firebase.dart';

abstract class FirebaseState extends Equatable {
  final UserFirebase userFirebase;

  const FirebaseState(this.userFirebase);

  @override
  List<Object?> get props => [userFirebase];
}

class FirebaseInitial extends FirebaseState {
  FirebaseInitial() : super(UserFirebase.empty());
}

class FirebaseFailure extends FirebaseState {
  final String error;
  const FirebaseFailure(this.error, userFirebase) : super(userFirebase);

  @override
  List<Object?> get props => [error, userFirebase];
}

class FirebaseAccountRemoving extends FirebaseState {
  const FirebaseAccountRemoving(super.userFirebase);
}

class FirebaseAccountRemoved extends FirebaseState {
  FirebaseAccountRemoved() : super(UserFirebase.empty());
}
