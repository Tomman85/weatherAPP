import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/models/custom_error_model/custom_error_model.dart';
import 'package:weather/services/repository_services/firebase_repository/auth_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit({required this.authRepository}) : super(SignUpState.initial());

  Future<void> SignUp({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signUpStatus: SignUpStatus.submitting));
    try {
      await authRepository.signUp(email: email, password: password, name: email.split('@')[0]);
      emit(
        state.copyWith(
          signUpStatus: SignUpStatus.success,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(signUpStatus: SignUpStatus.error, error: e),
      );
    }
  }
}
