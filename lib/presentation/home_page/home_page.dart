import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/presentation/search_page/search_page.dart';
import 'package:weather/presentation/settings_page/settings_page.dart';
import 'package:weather/reusable_widgets/border_text_style.dart';
import 'components/main_page_weather_content.dart';

class HomePage extends StatefulWidget {
  static const homePageRouteName = '/homepage';

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String splitBox(Box box) {
  String boxToString =
      box.isEmpty ? '' : box.getAt(box.length - 1).cityName.toString();
  return boxToString.split(',')[0];
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Hive.box(favCity).isEmpty
          ? const SearchPage()
          : const MainPageWeatherContent(),
    );
  }
}
