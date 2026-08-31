import 'package:equatable/equatable.dart';

import '../../models/profile_detail.dart';

abstract class ProfileDetailState extends Equatable {
  final ProfileDetail profileDetail;

  const ProfileDetailState(this.profileDetail);

  @override
  List<Object?> get props => [profileDetail];
}

class ProfileDetailInitial extends ProfileDetailState {
  const ProfileDetailInitial(super.profileDetail);
}

class ProfileDetailLoading extends ProfileDetailState {
  const ProfileDetailLoading(super.profileDetail);
}

class ProfileDetailSuccess extends ProfileDetailState {
  const ProfileDetailSuccess(super.profileDetail);
}

class ProfileDetailFailure extends ProfileDetailState {
  final String error;

  const ProfileDetailFailure(this.error, super.profileDetail);

  @override
  List<Object?> get props => [error, profileDetail];
}
