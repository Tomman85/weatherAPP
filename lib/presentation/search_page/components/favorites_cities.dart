import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/credentials.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/presentation/models/hive_box_models/model_list_of_cities.dart';
import 'package:weather/presentation/models/hive_box_models/model_single_city.dart';
import 'package:weather/presentation/models/openweather_model/current_data_response.dart';
import 'package:weather/presentation/models/openweather_model/weather_model.dart';
import 'package:weather/presentation/models/openweather_model/hourly_data_response.dart';
import 'package:weather/presentation/search_page/components/delete_autocomplete_background.dart';
import 'package:weather/presentation/services/http_openweather_service.dart';

class FavoritesCities extends StatefulWidget {
  const FavoritesCities({Key? key}) : super(key: key);

  @override
  State<FavoritesCities> createState() => _FavoritesCitiesState();
}

class _FavoritesCitiesState extends State<FavoritesCities> {
  HttpWeatherService? httpService;

  ListCurrentModelData? currentDataResponse;
  WeatherModel? predictionModel;

  bool isLoading = false;

  Future getCurrentWeather(lat, lon) async {
    Response? response;
    try {
      isLoading = true;
      response = await httpService?.getRequest(
          "lat=$lat&lon=$lon&units=metric&exclude=minutely,hourly,daily,alerts&appid=$openWeatherApi4");
      isLoading = false;

      if (response?.statusCode == 200) {
        currentDataResponse = ListCurrentModelData.fromJson(response?.data);
        predictionModel = currentDataResponse?.currentWeatherModel;
      } else {
        print('not good');
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
    return predictionModel;
  }

  @override
  void initState() {
    httpService = HttpWeatherService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(favCity).listenable(),
        builder: (context, value, _) {
          final citiesList = Hive.box(favCity).values.toList();

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            height: 600,
            child: Hive.box(favCity).isEmpty
                ? Text('Task na next week')
                : ListView.builder(
                    itemCount: Hive.box(favCity).length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = citiesList[index];

                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            setState(() {
                              // citiesList.removeAt(index);
                              Hive.box(favCity).deleteAt(index);
                            });
                          } else if (direction == DismissDirection.endToStart) {
                            print('Dodaj do main page');
                          }
                        },
                        confirmDismiss: (DismissDirection direction) async {
                          return await buildShowDialog(context);
                        },
                        background: const DeleteAutocompleteBackground(),
                        child: GestureDetector(
                          onTap: () {
                            Hive.box(mainCity).putAt(
                              0,
                              DataSingleModel(
                                latitude: item.latitude,
                                longitude: item.longitude,
                                cityName: item.cityName,
                              ),
                            );

                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 15,
                            ),
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue.shade800,
                              // gradient: LinearGradient(
                              //   begin: Alignment.topCenter,
                              //   end: Alignment.bottomCenter,
                              //   colors: [
                              //     Colors.lightBlue,
                              //     Colors.lightBlue.shade600,
                              //   ],
                              // ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            height: 110,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      width: 200,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          item.cityName.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                FutureBuilder(
                                  future: getCurrentWeather(
                                    item.latitude.toString(),
                                    item.longitude.toString(),
                                  ),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return Center(
                                        child: Text(
                                          "${snapshot.data.temperature.toStringAsFixed(0)} \u00B0",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }

                                    // By default, show a loading spinner.
                                    return const CircularProgressIndicator(
                                      color: Colors.white,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
        });
  }

  Future<bool?> buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Potwierdź usunięcię"),
          content: const Text(
              "Czy jesteś pewny aby usunać miasto z listy ulubionych?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                "Usuń",
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                "Anuluj",
              ),
            ),
          ],
        );
      },
    );
  }
}
