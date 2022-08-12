import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:weather/models/hive_box_models/model_list_of_cities.dart';

class Authentication {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<void> clearAndUpdate() async {
    await Hive.box(favCity).clear();
    return db
        .collection('users')
        .doc(fbAuth.FirebaseAuth.instance.currentUser?.uid)
        .get(GetOptions(source: Source.server))
        .then(
      (value) {
        List citiesFromFirebase = value.get('cities');
        for (int i = 0; i < citiesFromFirebase.length; i++) {
          Hive.box(favCity).add(
            DataModel(
              latitude: value.get('cities')[i]['position'].latitude.toString(),
              longitude:
                  value.get('cities')[i]['position'].longitude.toString(),
              cityName: value.get('cities')[i]['cityName'],
            ),
          );
        }
      },
    );
  }

  static Future<void> updateDataWhenRegisterAndLogin() async {
    final List cityList = [];

    Hive.box(favCity).values.toList().forEach((element) {
      final Map cityMap = {};

      cityMap['cityName'] = element.cityName;
      cityMap['position'] = GeoPoint(
          double.parse(element.latitude), double.parse(element.longitude));
      cityList.add(cityMap);
      // final c = ;
    });

    db
        .collection("users")
        .doc(fbAuth.FirebaseAuth.instance.currentUser?.uid)
        .set({
      'cities': cityList
    }, SetOptions(merge: true));
  }

  static Future<void> updateData() async {
    final updates = <String, dynamic>{
      "cities": FieldValue.delete(),
    };
    db
        .collection('users')
        .doc(fbAuth.FirebaseAuth.instance.currentUser?.uid)
        .update(updates);
    Hive.box(favCity).values.toList().forEach((element) {
      final Map myList = {};
      final List elo = [];
      myList['cityName'] = element.cityName;
      myList['position'] = GeoPoint(
          double.parse(element.latitude), double.parse(element.longitude));
      elo.add(myList);
      db
          .collection("users")
          .doc(fbAuth.FirebaseAuth.instance.currentUser?.uid)
          .set(
        {'cities': FieldValue.arrayUnion(elo)},
        SetOptions(merge: true),
      );
    });
  }

  static Future<void> clearAllData() async {
    db
        .collection("users")
        .doc(fbAuth.FirebaseAuth.instance.currentUser?.uid)
        .set(
      {'cities': []},
      SetOptions(merge: true),
    );
  }

  static final passwordValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'emptyPassword'.tr),
      MinLengthValidator(8, errorText: 'shortPassword'.tr),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'specialPassword'.tr)
    ],
  );
}
