import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/models/custom_error_model/custom_error_model.dart';
import 'package:weather/services/repository_services/firebase_repository/auth_repository.dart';
import 'package:weather/models/custom_error_model/custom_error_model.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;

  SignInCubit({required this.authRepository}) : super(SignInState.initial());

  Future<void> SignIn({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signInStatus: SignInStatus.submitting));
    try {
      await authRepository.signIn(email: email, password: password);
      emit(
        state.copyWith(
          signInStatus: SignInStatus.success,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(signInStatus: SignInStatus.error, error: e),
      );
    }
  }
}
