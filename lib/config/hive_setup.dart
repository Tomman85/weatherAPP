import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/models/hive_box_models/model_list_of_cities.dart';
import 'package:weather/models/hive_box_models/model_single_city.dart';

Future<void> hiveInitialization() async {
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  Hive.init(
    appDocumentDirectory.path,
  );

  Hive.registerAdapter(
    DataModelAdapter(),
  );

  Hive.registerAdapter(
    DataSingleModelAdapter(),
  );

  await Hive.openBox(
    favCity,
  );
  await Hive.openBox(
    mainCity,
  );

  Hive.box(mainCity).add(
    DataSingleModel(
      latitude: "",
      longitude: "",
      cityName: "",
    ),
  );
}
