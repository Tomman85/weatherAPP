import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather/models/user_model/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addUserData(User userData) async {
    await _db.collection("Users").doc(userData.id).set(userData.toMap());
  }

  Future<List> retrieveUserData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("Users").get();
    return snapshot.docs
        .map((docSnapshot) => User.fromDoc(docSnapshot))
        .toList();
  }

  Future<String> retrieveUserName(User user) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("Users").doc(user.id).get();
    return snapshot.data()!["displayName"];
  }
}