import 'package:equatable/equatable.dart';

import '../../models/profile_detail.dart';

abstract class ProfileEditState extends Equatable {
  const ProfileEditState();

  @override
  List<Object?> get props => [];
}

class ProfileEditInitial extends ProfileEditState {
  const ProfileEditInitial();
}

class ProfileEditLoading extends ProfileEditState {
  const ProfileEditLoading();
}

class ProfileEditSuccess extends ProfileEditState {
  final ProfileDetail profileDetail;

  const ProfileEditSuccess(this.profileDetail);

  @override
  List<Object?> get props => [profileDetail];
}

class ProfileEditFailure extends ProfileEditState {
  final String error;

  const ProfileEditFailure(this.error);

  @override
  List<Object?> get props => [error];
}
