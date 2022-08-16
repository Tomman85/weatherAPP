import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather/const/db_constants.dart';
import 'package:weather/models/custom_error_model/custom_error_model.dart';
import 'package:weather/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

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
    } on FirebaseException catch (_) {
      throw CustomError();
    } catch (e) {
      throw CustomError(
          code: 'Exception',
          message: e.toString(),
          plugin: 'flutter_error/server_error');
    }
  }

  void deleteCurrentUserDatabase() {
    usersRef.doc(fb_auth.FirebaseAuth.instance.currentUser?.uid).delete();
  }



}
