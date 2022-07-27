import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/presentation/search_page/search_page.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: Hive.box(favCity).listenable(),
          builder: (BuildContext context, value, Widget? child) {
            var box = Hive.box(favCity);

            return box.isEmpty
                ? Text(
                    'brak',
                  )
                : Text(
                    box.getAt(box.length - 1).cityName.toString().split(',')[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  );
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.blue.shade200,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              SearchPage.searchPageRouteName,
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: const MainPageWeatherContent(),
    );
  }
}
