import 'config/environment.dart';
import 'main.dart';

Future<void> main() async {
  await mainCommon(Environment.dev);
}
