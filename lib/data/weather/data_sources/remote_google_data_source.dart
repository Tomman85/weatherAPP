// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';
// import 'package:weather/data/weather/dto/predictions/google_autocomplete_rsponse.dart';
// part 'remote_google_data_source.g.dart';
// //AIzaSyBjnR2H5bYr0tUZR9HWd0Rcoiy6C8dbKWo
//
// @RestApi(baseUrl:'https://maps.googleapis.com/maps/api/place/autocomplete/' )
// abstract class RemoteGoogleAutocompleteSource {
//   factory RemoteGoogleAutocompleteSource(Dio dio, {String baseUrl}) = _RemoteGoogleAutocompleteSource;
//
//
//   @GET('/json?input={name}&types=(cities)&key=AIzaSyBFBMZrSA1l0h6rUR5ywIt6zlxLBBuD0ag')
//   Future<GoogleAutocompleteResponseDto> getListOfCities(
//       @Path() String name);
//
//
//   //pobieranie danych z google i pokazanie listy dostepnych miast
//
//   //po klinknieciu w dane miasto pobiera long i lat
//
//
// }
