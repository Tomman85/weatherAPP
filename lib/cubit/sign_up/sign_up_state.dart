
part of 'sign_up_cubit.dart';



enum SignUpStatus {
  initial,
  submitting,
  success,
  error,
}

class SignUpState {
  final SignUpStatus signUpStatus;
  final CustomError error;

  SignUpState({
    required this.signUpStatus,
    required this.error,
  });

  factory SignUpState.initial() {
    return SignUpState(
      signUpStatus: SignUpStatus.initial,
      error: CustomError(),
    );
  }

  SignUpState copyWith({
    SignUpStatus? signUpStatus,
    CustomError? error,
  }) {
    return SignUpState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      error: error ?? this.error,
    );
  }
}
