part of 'user_cubit.dart';

enum ProfileStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProfileState {
  final ProfileStatus profileStatus;
  final User user;
  final CustomError customError;

  const ProfileState({
    required this.profileStatus,
    required this.user,
    required this.customError,
  });

  factory ProfileState.initial() {
    return ProfileState(
      profileStatus: ProfileStatus.initial,
      user: User.initialUser(),
      customError: CustomError(),
    );
  }

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    User? user,
    CustomError? customError,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
      customError: customError ?? this.customError,
    );
  }
}
