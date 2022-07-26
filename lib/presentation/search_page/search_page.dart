import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/presentation/search_page/components/autocomplete.dart';
import 'package:weather/presentation/search_page/components/favorites_cities.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const searchPageRouteName = '/searchPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Hive.box(favCity).clear();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
         const  SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'cityManagement'.tr,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
         const  SizedBox(
            height: 20,
          ),
          const AutocompletePredictions(),
          const FavoritesCities(),
        ],
      ),
    );
  }
}
