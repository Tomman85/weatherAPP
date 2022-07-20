import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/credentials.dart';
import 'package:weather/presentation/models/autocomplete_model/list_response.dart';
import 'package:weather/presentation/models/autocomplete_model/prediction_model.dart';
import 'package:weather/presentation/models/hive_box_models/model_list_of_cities.dart';
import 'package:weather/presentation/models/openweather_model/list_openweather_response.dart';
import 'package:weather/presentation/services/http_autocomplete_service.dart';

class AutocompletePredictions extends StatefulWidget {
  const AutocompletePredictions({Key? key}) : super(key: key);

  @override
  State<AutocompletePredictions> createState() =>
      _AutocompletePredictionsState();
}

class _AutocompletePredictionsState extends State<AutocompletePredictions> {
  HttpService? httpService;

  ListPredictionsData? listDataResponse;
  List<PredictionModel>? predictionModel;
  bool isLoading = false;
  Position? _position;
  String? _currentAddress;

  Future getListUser(name) async {
    Response? response;
    try {
      isLoading = true;
      response = await httpService?.getRequest(
          "?text=$name&format=json&lang=pl&apiKey=$autocompleteApi");
      print(response?.statusCode);

      isLoading = false;

      if (response?.statusCode == 200) {
        setState(() {
          listDataResponse = ListPredictionsData.fromJson(response?.data);
          predictionModel = listDataResponse?.predictionModel;
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
    httpService = HttpService();
    super.initState();
  }

  @override
  void dispose() {
    httpService = HttpService();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Autocomplete<PredictionModel>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              getListUser(textEditingValue.text);
              if (textEditingValue.text == '' ||
                  textEditingValue.text.length < 3) {
                return const Iterable<PredictionModel>.empty();
              }

              return predictionModel!.where((PredictionModel option) {
                return option.formatted!
                    .toLowerCase()
                    .startsWith(textEditingValue.text.toLowerCase());
              });
            },
            displayStringForOption: (PredictionModel option) =>
                option.formatted.toString(),
            fieldViewBuilder: (BuildContext context,
                TextEditingController fieldTextEditingController,
                FocusNode fieldFocusNode,
                VoidCallback onFieldSubmitted) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Wyszukaj miasto',
                    fillColor: Colors.grey.shade200,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.location_on_outlined,
                        size: 30,
                      ),
                      color: Colors.grey.shade900,
                      onPressed: () async {
                        LocationPermission permission;
                        permission = await Geolocator.requestPermission();
                        _getCurrentLocation();
                        if (_currentAddress != null) {
                          Hive.box(favCity).add(
                            DataModel(
                              latitude: _position!.latitude.toString(),
                              longitude: _position!.longitude.toString(),
                              cityName: _currentAddress,
                            ),
                          );
                        }
                      },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30.0,
                        ),
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30.0,
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
            onSelected: (PredictionModel selection) {
              print('Selected: ${selection.latitude} ${selection.longitude}');
            },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<PredictionModel> onSelected,
                Iterable<PredictionModel> options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final PredictionModel option = options.elementAt(index);
                        print(options.elementAt(index).formatted);
                        return GestureDetector(
                          onTap: () {
                            onSelected(option);
                            var box = Hive.box(favCity);
                            //TODO tylko mozna dodac pojeedyncze
                            box.add(
                              DataModel(
                                longitude: option.longitude.toString(),
                                latitude: option.longitude.toString(),
                                cityName: option.formatted.toString(),
                              ),
                            );
                            setState(() {});
                          },
                          child: isLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: SizedBox(
                                      child: CircularProgressIndicator(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                              : ListTile(
                                  title: Text(
                                    option.formatted.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _position = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _position!.latitude, _position!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}
