import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template_app_flutter/core/exceptions/app_exception.dart';

import '../../models/profile_detail.dart';
import '../../repositories/profile_repository.dart';
import 'profile_detail_event.dart';
import 'profile_detail_state.dart';

class ProfileDetailBloc extends Bloc<ProfileDetailEvent, ProfileDetailState> {
  final ProfileRepository profileRepository;

  ProfileDetailBloc(this.profileRepository)
    : super(ProfileDetailInitial(ProfileDetail.empty())) {
    on<GetProfileDetail>(_onGetProfileDetail, transformer: restartable());
  }

  Future<void> _onGetProfileDetail(
    GetProfileDetail event,
    Emitter<ProfileDetailState> emit,
  ) async {
    emit(ProfileDetailLoading(state.profileDetail));
    try {
      final newProfileDetail = await profileRepository.getProfileById(
        event.profileId,
      );
      emit(ProfileDetailSuccess(newProfileDetail));
    } on AppException {
      emit(ProfileDetailFailure('error.request_failed', state.profileDetail));
    } on Exception {
      emit(ProfileDetailFailure('error.unexpected', state.profileDetail));
    }
  }
}
