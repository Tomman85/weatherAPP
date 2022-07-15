// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_weather_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _RemoteWeatherDataSource implements RemoteWeatherDataSource {
  _RemoteWeatherDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.openweathermap.org/data/2.5/onecall?';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<WeatherDto> getdataWeatherfromGPSLocation(lon, lat, part) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        WeatherDto>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            'lat={lat}&lon=${lon}&exclude={part}&appid=2bfa2b0d26ce02fbcba7ba428cb2bc4c',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WeatherDto.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WeatherDto> getCurrentWeatherfromCustomLocation(lon, lat) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        WeatherDto>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            'lat={lat}&lon=${lon}&exclude={part}&appid=2bfa2b0d26ce02fbcba7ba428cb2bc4c',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WeatherDto.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WeatherDto> getHourlyWeatherfromGpsLocation(lon, lat) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        WeatherDto>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            'lat={lat}&lon=${lon}&exclude={part}&appid=2bfa2b0d26ce02fbcba7ba428cb2bc4c',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WeatherDto.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WeatherDto> getHourlyWeatherfromCustomLocation(lon, lat) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        WeatherDto>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            'lat={lat}&lon=${lon}&exclude={part}&appid=2bfa2b0d26ce02fbcba7ba428cb2bc4c',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WeatherDto.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
