import 'package:equatable/equatable.dart';

import '../../models/profile_edit.dart';

abstract class ProfileEditEvent extends Equatable {
  const ProfileEditEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfile extends ProfileEditEvent {
  final String profileId;
  final ProfileEdit profileEdit;

  const UpdateProfile(this.profileId, this.profileEdit);

  @override
  List<Object?> get props => [profileId, profileEdit];
}
