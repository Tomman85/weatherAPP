import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String email;
  final String name;

  User({
    required this.id,
    required this.email,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': name,
      'age': id,
    };
  }

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>;
    return User(
      id: userDoc.id,
      email: userData['email'],
      name: userData['name'],
    );
  }

  factory User.initialUser() {
    return User(
      id: '',
      email: '',
      name: '',
    );
  }



}
