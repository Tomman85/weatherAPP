import 'package:weather/main.dart';
import 'config/environment.dart';

Future<void> main() async {
  await mainCommon(Environment.prod);
}
