import 'package:equatable/equatable.dart';

class ProfileImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileImageUpload extends ProfileImageEvent {
  final String profileId;
  final String filePath;

  ProfileImageUpload(this.profileId, this.filePath);

  @override
  List<Object> get props => [profileId, filePath];
}
