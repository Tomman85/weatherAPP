import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:weather/const/db_constants.dart';
import 'package:weather/const/hive_box_names.dart';
import 'package:weather/models/custom_error_model/custom_error_model.dart';
import 'package:weather/models/hive_box_models/model_list_of_cities.dart';
import 'package:weather/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

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

  void deleteCurrentUserDatabase() {
    usersRef.doc(fbAuth.FirebaseAuth.instance.currentUser?.uid).delete();
  }

}
