import 'package:equatable/equatable.dart';
import '../../models/profile_image.dart';

class ProfileImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileImageInitial extends ProfileImageState {}

class ProfileImageLoading extends ProfileImageState {}

class ProfileImageSuccess extends ProfileImageState {
  final ProfileImage profileImage;

  ProfileImageSuccess(this.profileImage);

  @override
  List<Object> get props => [profileImage];
}

class ProfileImageFailure extends ProfileImageState {
  final String error;

  ProfileImageFailure(this.error);

  @override
  List<Object> get props => [error];
}
