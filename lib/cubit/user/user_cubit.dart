import 'package:bloc/bloc.dart';
import 'package:weather/models/custom_error_model/custom_error_model.dart';
import 'package:weather/models/user_model/user_model.dart';
import 'package:weather/services/repository_services/firebase_repository/profile_repository.dart';
part 'user_state.dart';

class UserCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  UserCubit({
    required this.profileRepository,
  }) : super(ProfileState.initial());

  Future<void> getProfile({required String? uid}) async {
    emit(
      state.copyWith(
        profileStatus: ProfileStatus.loading,
      ),
    );
    try {
      if (uid != null) {
        final User user = await profileRepository.getProfile(uid: uid);
        emit(state.copyWith(
          profileStatus: ProfileStatus.loaded,
          user: user,
        ));
      }
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          profileStatus: ProfileStatus.error,
          customError: e,
        ),
      );
    }
  }

  Future<void> initialUser() async {
    emit(ProfileState.initial());
  }


}
