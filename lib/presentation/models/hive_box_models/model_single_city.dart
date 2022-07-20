import 'package:hive/hive.dart';

part 'model_single_city.g.dart';

@HiveType(typeId: 1)
class DataSingleModel {
  @HiveField(0)
  final String latitude;
  @HiveField(1)
  final String longitude;
  @HiveField(2)
  final String? cityName;

  DataSingleModel({
    required this.latitude,
    required this.longitude,
    required this.cityName,

  });
}
