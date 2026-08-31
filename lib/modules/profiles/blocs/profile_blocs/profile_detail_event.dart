import 'package:equatable/equatable.dart';

abstract class ProfileDetailEvent extends Equatable {
  const ProfileDetailEvent();

  @override
  List<Object?> get props => [];
}

class GetProfileDetail extends ProfileDetailEvent {
  final String profileId;

  const GetProfileDetail(this.profileId);

  @override
  List<Object?> get props => [profileId];
}
