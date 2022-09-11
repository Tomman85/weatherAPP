class CityFirebase {
  final String latitude;
  final String longitude;
  final String cityName;

  const CityFirebase({
    required this.latitude,
    required this.longitude,
    required this.cityName,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "city": cityName,
    };
  }
}
