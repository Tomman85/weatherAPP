import 'package:hive/hive.dart';

part 'model_list_of_cities.g.dart';

@HiveType(typeId: 0)
class DataModel {
  @HiveField(0)
  final String latitude;
  @HiveField(1)
  final String longitude;
  @HiveField(2)
  final String? cityName;

  DataModel({
    required this.latitude,
    required this.longitude,
    required this.cityName,

  });
}
