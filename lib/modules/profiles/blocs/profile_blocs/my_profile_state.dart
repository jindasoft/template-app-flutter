import 'package:equatable/equatable.dart';

import '../../models/my_profile.dart';

abstract class MyProfileState extends Equatable {
  final MyProfile profileDetail;

  const MyProfileState(this.profileDetail);

  @override
  List<Object?> get props => [profileDetail];
}

class MyProfileInitial extends MyProfileState {
  const MyProfileInitial(super.profileDetail);
}

class MyProfileLoading extends MyProfileState {
  const MyProfileLoading(super.profileDetail);
}

class MyProfileSuccess extends MyProfileState {
  const MyProfileSuccess(super.profileDetail);
}

class MyProfileFailure extends MyProfileState {
  final String error;

  const MyProfileFailure(this.error, super.profileDetail);

  @override
  List<Object?> get props => [error, profileDetail];
}
