import 'package:flutter/material.dart';
import 'dart:core';
import 'package:get/get.dart';

class LanguageFormat {
  static void changeLanguage() {
    if (Get.locale == const Locale('pl', 'PL')) {
      Get.updateLocale(const Locale('en', 'EN'));
    } else {
      Get.updateLocale(const Locale('pl', 'PL'));
    }
  }
}
