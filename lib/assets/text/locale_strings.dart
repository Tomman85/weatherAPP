import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'sunrise': 'Sunrise',
          'sunset': 'Sunset',
          'feelTemperature': 'Wind chill',
          'humidity': 'Humidity',
          'indexUV': 'UV Index',
          'pressure': 'Pressure',
          'cityManagement': 'Cities management',
          'searchCity': 'Search city',
          'moveToDelete': 'Move to remove',
          'confirmDelete': 'Confirm remove',
          'areYouSure': 'Are You sure to delete this city from the list?',
          'deleteCity': 'Remove',
          'cancelDelete': 'Cancel',
          'caution': 'Caution',
          'disableContent': 'Location services are disabled.',
          'deniedContent': 'Location permissions are denied',
          'permanentlyDeniedContent':
              'Location permissions are permanently denied, we cannot request permissions.',
          'ok': 'OK',
          'language': 'en',
        },
        'pl_PL': {
          'sunrise': 'Wschód',
          'sunset': 'Zachód',
          'feelTemperature': 'Odczuwalnie',
          'humidity': 'Wilgotność',
          'indexUV': 'UV Index',
          'pressure': 'Ciśnienie',
          'cityManagement': 'Zarządzaj miastami',
          'searchCity': 'Wyszukaj miasto',
          'moveToDelete': 'Przesuń aby usunąć',
          'confirmDelete': 'Potwierdź usunięcie',
          'areYouSure':
              'Czy jesteś pewny aby usunać miasto z listy ulubionych?',
          'deleteCity': 'Usuń',
          'cancelDelete': 'Anuluj',
          'caution': 'Uwaga',
          'disableContent': 'Lokalizacja jest wyłączona.',
          'deniedContent': 'Odmowa uprawnień do lokalizacji.',
          'permanentlyDeniedContent':
              'Uprawnienia dotyczące lokalizacji są trwale wyłączone, nie możemy prosić o uprawnienia.',
          'ok': 'OK',
          'language': 'pl',
        }
      };
}
