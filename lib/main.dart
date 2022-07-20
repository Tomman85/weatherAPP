import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/presentation/home_page/home_page.dart';
import 'package:weather/presentation/models/hive_box_models/model_list_of_cities.dart';
import 'package:weather/presentation/models/hive_box_models/model_single_city.dart';
import 'package:weather/presentation/search_page/search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =
  await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(DataModelAdapter());
  Hive.registerAdapter(DataSingleModelAdapter());
  await Hive.openBox(favCity);
  await Hive.openBox(mainCity);
  Hive.box(mainCity).add(
      DataSingleModel(latitude: "", longitude: "", cityName: ""));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
