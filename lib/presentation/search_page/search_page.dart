import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/presentation/search_page/components/autocomplete.dart';
import 'package:weather/presentation/search_page/components/favorites_cities.dart';
import 'package:weather/utils/custom_typography.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const searchPageRouteName = '/searchPage';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    Box box = Hive.box(favCity);

    return Scaffold(
      appBar: AppBar(

        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
                Hive.box(favCity).clear();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'cityManagement'.tr,
              textAlign: TextAlign.end,
              style: CustomTypography.textStyleSettingsTitle,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const AutocompletePredictions(),
          const FavoritesCities(),
        ],
      ),
    );
  }
}
