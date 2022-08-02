import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/presentation/search_page/search_page.dart';
import 'package:weather/presentation/settings_page/settings_page.dart';
import 'package:weather/utils/border_text_style.dart';
import 'components/main_page_weather_content.dart';

class HomePage extends StatefulWidget {
  static const homePageRouteName = '/homepage';

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(SettingsPage.settingsPageRouteName);
            },
            icon: const DecoratedIcon(
              decoration: IconDecoration(
                border: IconBorder(
                  color: Colors.black26,
                  width: 5,
                ),
              ),
              icon: Icon(
                Icons.settings,
              ),
            ),
          ),
        ],
        title: ValueListenableBuilder(
          valueListenable: Hive.box(favCity).listenable(),
          builder: (BuildContext context, value, Widget? child) {
            var box = Hive.box(favCity);

            return box.isEmpty
                ? Text(
                    'brak',
                  )
                : BorderTextStyle(
                    child: Text(
                      box
                          .getAt(box.length - 1)
                          .cityName
                          .toString()
                          .split(',')[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  );
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              SearchPage.searchPageRouteName,
            );
          },
          child: const DecoratedIcon(
            icon: Icon(Icons.add_circle_outlined),
            decoration: IconDecoration(
              border: IconBorder(
                color: Colors.black26,
                width: 6,
              ),
            ),
          ),
        ),
      ),
      body: const MainPageWeatherContent(),
    );
  }
}
