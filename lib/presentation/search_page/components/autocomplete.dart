import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:weather/bloc/auth/auth_bloc.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/models/autocomplete_model/list_response.dart';
import 'package:weather/models/autocomplete_model/prediction_model.dart';
import 'package:weather/models/hive_box_models/model_list_of_cities.dart';
import 'package:weather/services/repository_services/autocomplete_repository_service/autocomplete_repository_service.dart';
import 'package:weather/utils/authentications.dart';
import 'package:weather/utils/autocomplete_show_dialog.dart';
import 'package:weather/utils/custom_typography.dart';

class AutocompletePredictions extends StatefulWidget {
  const AutocompletePredictions({Key? key}) : super(key: key);

  @override
  State<AutocompletePredictions> createState() =>
      _AutocompletePredictionsState();
}

class _AutocompletePredictionsState extends State<AutocompletePredictions> {
  ListPredictionsData? listDataResponse;
  List<PredictionModel>? predictionModel;
  bool isLoading = false;
  Position? _position;
  String? _currentAddress;

  @override
  Widget build(BuildContext context) {
    Box box = Hive.box(favCity);
    bool checkAddress = false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Autocomplete<PredictionModel>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '' ||
                  textEditingValue.text.length < 3) {
                return const Iterable<PredictionModel>.empty();
              }
              _getAutocompletePredictions(
                textEditingValue.text,
                'sLanguage'.tr,
              );
              if (predictionModel == null) {
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
                    hintText: "searchCity".tr,
                    fillColor: Colors.grey.shade200,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.location_on_outlined,
                        size: 30,
                      ),
                      color: Colors.grey.shade900,
                      onPressed: () async {
                        _getCurrentLocation();

                        box.values.toList().forEach((element) {
                          if (_currentAddress == element.cityName) {
                            checkAddress = true;
                          }
                        });
                        if (_currentAddress != null && !checkAddress) {
                          box.add(
                            DataModel(
                              latitude: _position!.latitude.toString(),
                              longitude: _position!.longitude.toString(),
                              cityName: _currentAddress,
                            ),
                          );
                        }
                        if (context.read<AuthBloc>().state.authStatus ==
                            AuthStatus.authenticated) {
                          Authentication.updateData();
                        }
                        setState(() {});
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
            onSelected: (PredictionModel selection) {},
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<PredictionModel> onSelected,
                Iterable<PredictionModel> options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final PredictionModel option = options.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            onSelected(option);
                            Hive.box(favCity)
                                .values
                                .toList()
                                .forEach((element) {
                              if (option.formatted.toString() ==
                                  element.cityName) {
                                checkAddress = true;
                              }
                            });
                            if (option.formatted != null && !checkAddress) {
                              Hive.box(favCity).add(
                                DataModel(
                                  longitude: option.longitude.toString(),
                                  latitude: option.latitude.toString(),
                                  cityName: option.formatted.toString(),
                                ),
                              );
                              checkAddress = false;
                            }
                            if (context.read<AuthBloc>().state.authStatus ==
                                AuthStatus.authenticated) {
                              Authentication.updateData();
                            }
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
                                    style: CustomTypography
                                        .textStyleAutocompleteBasic,
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

  void _getAutocompletePredictions(name, lang) async {
    isLoading = true;
    setState(() {});
    listDataResponse =
        await AutocompleteRepositoryService.getAutocompletePrediction(
            name, lang);
    predictionModel = listDataResponse?.predictionModel;
    isLoading = false;
    setState(() {});
  }

  void _getCurrentLocation() async {
    bool? serviceEnabled;
    LocationPermission? permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AutocompleteShowDialog.showCustomDialog(
        context: context,
        titleText: 'Caution'.tr,
        contentText: 'disableContent'.tr,
        childText: 'ok'.tr,
      );

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      AutocompleteShowDialog.showCustomDialog(
        context: context,
        titleText: 'Caution'.tr,
        contentText: 'deniedContent'.tr,
        childText: 'ok'.tr,
      );
      return Future.error('Location permissions are denied');
    }

    if (permission == LocationPermission.deniedForever) {
      AutocompleteShowDialog.showCustomDialog(
        context: context,
        titleText: 'Caution'.tr,
        contentText: 'permanentlyDeniedContent'.tr,
        childText: 'ok'.tr,
      );
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _position = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
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
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
