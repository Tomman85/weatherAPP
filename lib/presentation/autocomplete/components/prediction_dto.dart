// //retrifot test
//
// import 'package:json_annotation/json_annotation.dart';
// import 'package:retrofit/retrofit.dart';
// import 'package:dio/dio.dart';
//
//
// @RestApi()
// abstract class ApiClient {
//   factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
//
//   @GET(
//       'https://api.geoapify.com/v1/geocode/autocomplete?text=ber&format=json&apiKey=09dbac0c276948199f26e5ce40662f1a')
//   Future<List<ResponseData>> getPrediction();
// }
//
// @JsonSerializable()
// class ResponseData{
//
//   String? data;
//   ResponseData({required this.data});
//   factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);
//   Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
//
// }

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
part 'prediction_dto.g.dart';

@RestApi(baseUrl: "http://www.json-generator.com/api/json/get/cffBLmFKeW?")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/indent=2")
  Future<Post> getTasks();

}

@JsonSerializable()
class Post {
  String? name;
  int? age;

  Post({
    required this.name,
    required this.age,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
