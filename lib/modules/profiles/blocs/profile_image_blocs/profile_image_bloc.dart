import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/profile_image_repository.dart';
import 'profile_image_event.dart';
import 'profile_image_state.dart';

class ProfileImageBloc extends Bloc<ProfileImageEvent, ProfileImageState> {
  final ProfileImageRepository repository;

  ProfileImageBloc(this.repository) : super(ProfileImageInitial()) {
    on<ProfileImageUpload>(_onProfileImageUpload, transformer: sequential());
  }

  Future<void> _onProfileImageUpload(
    ProfileImageUpload event,
    Emitter<ProfileImageState> emit,
  ) async {
    emit(ProfileImageLoading());
    try {
      final profileImage = await repository.uploadProfileImage(
        profileId: event.profileId,
        filePath: event.filePath,
      );
      emit(ProfileImageSuccess(profileImage));
    } catch (e) {
      emit(ProfileImageFailure(e.toString()));
    }
  }
}
