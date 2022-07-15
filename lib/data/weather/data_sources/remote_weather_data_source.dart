import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather/const/api_data.dart';
import 'package:weather/data/weather/dto/weather_dto.dart';

part 'remote_weather_data_source.g.dart';

@RestApi(baseUrl: "https://api.openweathermap.org/data/2.5/onecall?")
abstract class RemoteWeatherDataSource {
  factory RemoteWeatherDataSource(Dio dio, {String baseUrl}) =
      _RemoteWeatherDataSource;

  // var dio = Dio(BaseOptions(
  //   baseUrl: 'http://api.openweathermap.org/',
  // ));

  //onecallapi 1.0 for free


  //current weather from gps location
  @GET('lat={lat}&lon={lon}&exclude={part}&appid=$apiKey')
  Future<WeatherDto> getdataWeatherfromGPSLocation(
      @Path() String lon, String lat,String part);

//current weather from gps location
// @Get('data/2.5/weather?lat={lat}&lon={lon}&appid={API key}')

// current weather from custom location
  @GET('lat={lat}&lon={lon}&exclude={part}&appid=$apiKey')
  Future<WeatherDto> getCurrentWeatherfromCustomLocation(
      @Path() String lon, String lat);

// forecast weather from gps location hourly
  @GET('lat={lat}&lon={lon}&exclude={part}&appid=$apiKey')
  Future<WeatherDto> getHourlyWeatherfromGpsLocation(
      @Path() String lon, String lat);

//forecast weather from custom location hbh
  @GET('lat={lat}&lon={lon}&exclude={part}&appid=$apiKey')
  Future<WeatherDto> getHourlyWeatherfromCustomLocation(
      @Path() String lon, String lat);

//forecast weather from gps location day by day;

//forecast weather from custom location day by day

}
