import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/auth/auth_bloc.dart';
import 'package:weather/cubit/sign_in/sign_in_cubit.dart';
import 'package:weather/cubit/sign_up/sign_up_cubit.dart';
import 'package:weather/cubit/user/user_cubit.dart';
import 'package:weather/services/repository_services/firebase_repository/auth_repository.dart';
import 'package:weather/services/repository_services/firebase_repository/profile_repository.dart';

class BlocWrapper extends StatelessWidget {
  final Widget child;

  const BlocWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        BlocProvider<SignInCubit>(
          create: (context) => SignInCubit(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(
            profileRepository: context.read<ProfileRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
