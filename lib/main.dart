import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:weather/assets/text/locale_strings.dart';
import 'package:weather/config/hive_setup.dart';
import 'package:weather/cubit/sign_in/sign_in_cubit.dart';
import 'package:weather/cubit/user/user_cubit.dart';
import 'package:weather/presentation/home_page/home_page.dart';
import 'package:weather/presentation/login_page/login_page.dart';
import 'package:weather/presentation/search_page/search_page.dart';
import 'package:weather/presentation/settings_page/settings_page.dart';
import 'package:weather/services/network_services/network_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weather/services/repository_services/firebase_repository/auth_repository.dart';
import 'package:weather/services/repository_services/firebase_repository/profile_repository.dart';
import 'bloc/auth/auth_bloc.dart';
import 'cubit/sign_up/sign_up_cubit.dart';
import 'firebase_options.dart';
import 'const/page_name_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HiveSetup.hiveInitialization();

  runApp(const MyApp());
}

NetworkService networkService = NetworkService();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
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
        child: GetMaterialApp(
          locale: const Locale('pl', 'PL'),
          translations: LocaleString(),
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
          ),
          initialRoute: homePageRouteName,
          routes: {
            loginPageRouteName: (context) => const LoginPage(),
            homePageRouteName: (context) => const HomePage(),
            searchPageRouteName: (context) => const SearchPage(),
            settingsPageRouteName: (context) => const SettingsPage(),
          },
        ),
      ),
    );
  }
}
