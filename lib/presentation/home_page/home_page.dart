import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/presentation/models/hive_box_models/model_list_of_cities.dart';
import 'package:weather/presentation/models/hive_box_models/model_single_city.dart';
import 'package:weather/presentation/models/openweather_model/list_openweather_response.dart';
import 'package:weather/presentation/search_page/search_page.dart';
import 'package:weather/presentation/services/http_openweather_service.dart';

class HomePage extends StatefulWidget {
  static const homePageRouteName = '/homepage';

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpWeatherService? httpWeatherService;
  ListModelData? listModelData;
  List<ListModelData>? predictionModel;


  // Future getWeatherData(lon, lat) {
  //   Response? response;
  //   try {
  //     response = httpWeatherService?.getRequest(
  //             "lat=${lat}&lon=${lon}&appid=2bfa2b0d26ce02fbcba7ba428cb2bc4c")
  //         as Response?;
  //
  //     if (response?.statusCode == 200) {
  //       setState(() {
  //         listModelData = ListModelData.fromJson(response?.data);
  //         predictionModel =
  //             listModelData?.currentWeatherModel.cast<ListModelData>();
  //         print(predictionModel?.length);
  //       });
  //     } else {
  //       print("not good");
  //     }
  //   } on Exception catch (e) {
  //     throw Exception();
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    // Hive.openBox(mainCity);
    super.initState();
  }

  final List citiesList =
      Hive.box(mainCity).values.toList().cast<DataSingleModel>();

  @override
  Widget build(BuildContext context) {
    final item = citiesList[0];
    return Scaffold(
      appBar: AppBar(
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
      body: Container(
        color: Colors.blue.shade200,
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: Hive.box(mainCity).listenable(),
            builder: (BuildContext context, value, Widget? child) {
              final citiesList =
                  Hive.box(mainCity).values.toList().cast<DataSingleModel>();
              return Text(citiesList[0].cityName.toString());
            },
          ),
        ),
      ),
    );
  }
}
