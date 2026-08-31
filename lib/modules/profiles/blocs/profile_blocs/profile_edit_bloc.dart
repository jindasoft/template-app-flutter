import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template_app_flutter/core/exceptions/app_exception.dart';

import '../../repositories/profile_repository.dart';
import 'profile_edit_event.dart';
import 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  final ProfileRepository profileRepository;

  ProfileEditBloc(this.profileRepository) : super(ProfileEditInitial()) {
    on<UpdateProfile>(_onUpdateProfile, transformer: droppable());
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileEditState> emit,
  ) async {
    emit(ProfileEditLoading());
    try {
      final profile = await profileRepository.updateProfile(
        event.profileId,
        event.profileEdit,
      );
      emit(ProfileEditSuccess(profile));
    } on AppException {
      emit(ProfileEditFailure('error.request_failed'));
    } on Exception {
      emit(ProfileEditFailure('error.unexpected'));
    }
  }
}
