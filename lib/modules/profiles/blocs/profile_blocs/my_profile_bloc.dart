import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template_app_flutter/core/exceptions/app_exception.dart';

import '../../models/my_profile.dart';
import '../../repositories/profile_repository.dart';
import 'my_profile_event.dart';
import 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  final ProfileRepository profileRepository;

  MyProfileBloc(this.profileRepository)
    : super(MyProfileInitial(MyProfile.empty())) {
    on<GetMyProfile>(_onGetMyProfile, transformer: restartable());
  }

  Future<void> _onGetMyProfile(
    GetMyProfile event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(MyProfileLoading(state.profileDetail));
    try {
      final newProfileDetail = await profileRepository.getMyProfile();
      emit(MyProfileSuccess(newProfileDetail));
    } on AppException {
      emit(MyProfileFailure('error.request_failed', state.profileDetail));
    } on Exception {
      emit(MyProfileFailure('error.unexpected', state.profileDetail));
    }
  }
}
