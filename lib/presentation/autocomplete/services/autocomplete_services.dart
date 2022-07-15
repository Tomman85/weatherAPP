import 'dart:convert';

import 'package:dio/dio.dart';

import 'data_model.dart';

const String randomPersonURL = "https://randomuser.me/api/";

class PersonNetworkService {
  Future<List<DataModel>> fetchPersons() async {
    Response response = await Dio().get(
        'https://api.geoapify.com/v1/geocode/autocomplete?text=ber&format=json&apiKey=09dbac0c276948199f26e5ce40662f1a');
print(response.statusCode);
    if (response.statusCode == 200) {

      Map dataModel = jsonDecode(response.data);
      print(dataModel);
      List<dynamic> peoples = dataModel["results"];
      return peoples.map((json) => DataModel.fromJson(json)).toList();
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }
  }
}
