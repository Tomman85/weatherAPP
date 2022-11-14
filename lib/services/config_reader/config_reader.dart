import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:weather/config/environment.dart';

abstract class ConfigReader {
  static late Map<String, dynamic> _config;

  static Future<void> initialize() async {
    String configString;

    configString = await rootBundle.loadString('config/app_config.json');
    _config = json.decode(configString) as Map<String, dynamic>;
  }

  static String getOpenWeatherKey() => _config['openWeatherApi'] as String;
  static String getAutocompleteKey() => _config['autocompleteApi'] as String;
}
