import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:weather/const/db_constants.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/models/custom_error_model/custom_error_model.dart';
import 'package:weather/models/user_model/user_model.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;

  const ProfileRepository({
    required this.firebaseFirestore,
  });

  Future<User> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot userDoc = await usersRef.doc(uid).get();
      if (userDoc.exists) {
        final currentUser = User.fromDoc(userDoc);
        return currentUser;
      }
      throw 'User not found';
    } on FirebaseException catch (e) {
      throw CustomError();
    } catch (e) {
      throw CustomError(
          code: 'Exception',
          message: e.toString(),
          plugin: 'flutter_error/server_error');
    }
  }


 static Future<void> updateData(String uid) async {

    final Map<String, String> myMap = {};
    final db = FirebaseFirestore.instance;
db.collection("users").doc(uid).delete();
    Hive.box(favCity).values.toList().forEach((element) {
      print(element.cityName);
      myMap.addAll({
        'name': element.cityName.toString().split(",")[0],
        'latitude': element.latitude,
        'longitude': element.latitude,
      });

      db.collection("users").doc(uid).set(
        {element.cityName: myMap},
        SetOptions(merge: true),
      );
    });
  }
}
