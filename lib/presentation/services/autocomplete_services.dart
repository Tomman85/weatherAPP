// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:weather/presentation/models/prediction_model.dart';
//
// import 'data_model.dart';
//
//
// class PersonNetworkService {
//   Future<List<PredictionModel>> fetchPersons() async {
//     Response response = await Dio().get(
//         'https://api.geoapify.com/v1/geocode/autocomplete?text=ber&format=json&apiKey=09dbac0c276948199f26e5ce40662f1a');
// print(response.statusCode);
//     if (response.statusCode == 200) {
//
//       Map dataModel = jsonDecode(response.data);
//       print(dataModel);
//       List<dynamic> peoples = dataModel["results"];
//       return peoples.map((json) => PredictionM
//           del.fromJson(json)).toList();
//     } else {
//       throw Exception("Something gone wrong, ${response.statusCode}");
//     }
//   }
// }
