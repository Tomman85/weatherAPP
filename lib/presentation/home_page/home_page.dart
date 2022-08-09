import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/const/page_name_routes.dart';
import 'components/main_page_weather_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String splitBox(Box box) {
  String boxToString = box.getAt(box.length - 1).cityName.toString();
  return boxToString.split(',')[0];
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
              Navigator.of(context).pushNamed(settingsPageRouteName);
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
            Box box = Hive.box(favCity);
            return box.isEmpty
                ? Text(
                    'brak',style: TextStyle(color: Colors.blue),
                  )
                : BorderTextStyle(
                    child: Text(
                      splitBox(box),
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
              searchPageRouteName,
            );
          },
          child: const DecoratedIcon(
            icon: Icon(Icons.add_circle_outlined),
            decoration: IconDecoration(
              border: IconBorder(
                color: Colors.black26,
                width: 5,
              ),
            ),
          ),
        ),
      ),
      body: const MainPageWeatherContent(),
    );
  }
}
