import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/assets/text/locale_strings.dart';
import 'package:weather/config/hive_setup.dart';
import 'package:weather/presentation/home_page/home_page.dart';
import 'package:weather/presentation/search_page/search_page.dart';
import 'package:weather/services/network_services/network_service.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await hiveInitialization();

  runApp(const MyApp());
}

NetworkService networkService = NetworkService();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(

      locale: const Locale('pl', 'PL'),
      translations: LocaleString(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: HomePage.homePageRouteName,
      routes: {
        HomePage.homePageRouteName: (context) => const HomePage(),
        SearchPage.searchPageRouteName: (context) => const SearchPage(),
      },
    );
  }
}

