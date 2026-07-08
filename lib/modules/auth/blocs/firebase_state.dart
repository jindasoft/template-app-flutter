import 'package:equatable/equatable.dart';

import '../models/user_firebase.dart';

abstract class FirebaseState extends Equatable {
  final UserFirebase userFirebase;

  const FirebaseState(this.userFirebase);

  @override
  List<Object?> get props => [userFirebase];
}

class FirebaseInitial extends FirebaseState {
  const FirebaseInitial(super.userFirebase);
}

class FirebaseAccountRemoving extends FirebaseState {
  const FirebaseAccountRemoving(super.userFirebase);
}

class FirebaseAccountRemoveSuccess extends FirebaseState {
  const FirebaseAccountRemoveSuccess() : super(const UserFirebase.empty());
}

class FirebaseAccountRemoveFailure extends FirebaseState {
  final String error;
  const FirebaseAccountRemoveFailure(this.error, super.userFirebase);

  @override
  List<Object?> get props => [error, userFirebase];
}
