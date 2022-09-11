part of 'sign_in_cubit.dart';

enum SignInStatus {
  initial,
  submitting,
  success,
  error,
}

class SignInState {
  final SignInStatus signInStatus;
  final CustomError error;

  SignInState({
    required this.signInStatus,
    required this.error,
  });

  factory SignInState.initial() {
    return SignInState(
      signInStatus: SignInStatus.initial,
      error: CustomError(),
    );
  }

  SignInState copyWith({
    SignInStatus? signInStatus,
    CustomError? error,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      error: error ?? this.error,
    );
  }
}
