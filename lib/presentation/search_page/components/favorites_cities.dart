import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:weather/bloc/auth/auth_bloc.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/models/hive_box_models/model_list_of_cities.dart';
import 'package:weather/models/openweather_model/weather_data_response.dart';
import 'package:weather/presentation/search_page/components/delete_autocomplete_background.dart';
import 'package:weather/services/repository_services/openweather_repository_service/openweather_repository_service.dart';
import 'package:weather/utils/authentications.dart';
import 'package:weather/utils/custom_typography.dart';

class FavoritesCities extends StatefulWidget {
  const FavoritesCities({Key? key}) : super(key: key);

  @override
  State<FavoritesCities> createState() => _FavoritesCitiesState();
}

class _FavoritesCitiesState extends State<FavoritesCities> {
  ListWeatherDataModel? currentDataResponse;

  bool isLoading = false;

  Future _getCurrentWeatherData(lat, lon, lang) async {
    isLoading = true;
    currentDataResponse =
        await OpenweatherRepositoryService.getOpenweatherData(lat, lon, lang);
    isLoading = false;
    return currentDataResponse;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(favCity).listenable(),
      builder: (context, value, _) {
        var box = Hive.box(favCity);
        final citiesList = box.values.toList();
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          height: 600,
          child: box.isEmpty
              ? const Text('Task na next week')
              : ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = citiesList[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          box.deleteAt(index);
                          setState(() {});
                          if (context.read<AuthBloc>().state.authStatus ==
                              AuthStatus.authenticated) {
                            Authentication.updateData();
                          }
                        }
                        setState(() {});
                      },
                      confirmDismiss: (DismissDirection direction) async {
                        return await buildShowDialog(context);
                      },
                      background: const DeleteAutocompleteBackground(),
                      child: GestureDetector(
                        onTap: () {
                          box.deleteAt(index);
                          box.add(
                            DataModel(
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
                            color: Colors.lightBlue.shade800,
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
                                        style:
                                            CustomTypography.textStyleFavCity,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              FutureBuilder(
                                future: _getCurrentWeatherData(
                                  item.latitude.toString(),
                                  item.longitude.toString(),
                                  "pl",
                                ),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return Center(
                                      child: Text(
                                        "${snapshot.data.currentWeatherModel.temperature.toStringAsFixed(0)} \u00B0",
                                        style:
                                            CustomTypography.textStyleFavTemp,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }
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
      },
    );
  }
}

Future<bool?> buildShowDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("confirmDelete".tr),
        content: Text('areYouSure'.tr),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              "deleteCity".tr,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              "cancelDelete".tr,
            ),
          ),
        ],
      );
    },
  );
}
