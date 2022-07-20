import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/credentials.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/presentation/models/hive_box_models/model_list_of_cities.dart';
import 'package:weather/presentation/models/hive_box_models/model_single_city.dart';
import 'package:weather/presentation/models/openweather_model/list_current_weather.dart';
import 'package:weather/presentation/models/openweather_model/list_openweather_response.dart';
import 'package:weather/presentation/services/http_openweather_service.dart';

class FavoritesCities extends StatefulWidget {
  const FavoritesCities({Key? key}) : super(key: key);

  @override
  State<FavoritesCities> createState() => _FavoritesCitiesState();
}

class _FavoritesCitiesState extends State<FavoritesCities> {
  HttpWeatherService? httpService;

  ListModelData? listDataResponse;
  List<CurrentWeatherModel>? predictionModel;

  bool isLoading = false;

  Future getCurrentWeather(lat, lon) async {
    Response? response;
    try {
      isLoading = true;
      response = await httpService
          ?.getRequest("lat=$lat&lon=$lon&appid=$openWeatherApi");

      isLoading = false;

      if (response?.statusCode == 200) {
        print(response?.statusCode);

        setState(() {
          listDataResponse = ListModelData.fromJson(response?.data);
          predictionModel = listDataResponse?.currentWeatherModel;
        });
      } else {
        print('not good');
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    httpService = HttpWeatherService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox(favCity),
      builder: (context, snapshot) {
        return ValueListenableBuilder(
            valueListenable: Hive.box(favCity).listenable(),
            builder: (context, value, _) {
              final citiesList =
                  Hive.box(favCity).values.toList().cast<DataModel>();

              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                height: 600,
                child: ListView.builder(
                  itemCount: Hive.box(favCity).length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = citiesList[index];
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        setState(() {
                          Hive.box(favCity).deleteAt(index);
                        });
                      },
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
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 15,
                          ),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue.shade900,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          height: 110,
                          child: Row(
                            children: [
                              Align(
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
                              // SizedBox(
                              //   width: 50,
                              //   height: 50,
                              //   child: FutureBuilder(
                              //     future: getCurrentWeather(
                              //         item.latitude.toString(),
                              //         item.longitude.toString()),
                              //     builder: (context,  snapshot) {
                              //       if (snapshot.hasData) {
                              //         print(snapshot.data);
                              //         return Text(snapshot.data.toString());
                              //       } else if (snapshot.hasError) {
                              //         return Text('${snapshot.error}');
                              //       }
                              //
                              //       // By default, show a loading spinner.
                              //       return const CircularProgressIndicator();
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            });
      },
    );
  }
}
