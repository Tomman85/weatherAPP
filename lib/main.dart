import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weather/assets/text/locale_strings.dart';
import 'package:weather/config/hive_setup.dart';
import 'package:weather/presentation/home_page/home_page.dart';
import 'package:weather/presentation/login_page/login_page.dart';
import 'package:weather/presentation/search_page/search_page.dart';
import 'package:weather/presentation/settings_page/settings_page.dart';
import 'package:weather/services/config_reader/config_reader.dart';
import 'package:weather/services/network_services/network_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weather/wrappers/bloc_wrapper.dart';
import 'package:weather/wrappers/provider_wrapper.dart';
import 'firebase_options.dart';
import 'const/page_name_routes.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HiveSetup.hiveInitialization();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });

}


NetworkService networkService = NetworkService();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWrapper(
      child: BlocWrapper(
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
