import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUser {
  final String? id; // Store the UID from Firebase Auth
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? password;
  String? avatar = "https://reqres.in/img/faces/1-image.jpg";

  FirebaseUser({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.password,
    this.avatar,
  });

  // Factory constructor to create a FirebaseUser from Firestore
  factory FirebaseUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return FirebaseUser(
      id: snapshot.id, // Assign document ID (which should be UID)
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      phone: data?['phone'],
      email: data?['email'],
      password: data?['password'],
      avatar: data?['avatar'],
    );
  }

  // Convert FirebaseUser to a Firestore-compatible Map
  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id, // Ensure UID is stored
      if (firstName != null) "firstName": firstName,
      if (lastName != null) "lastName": lastName,
      if (phone != null) "phone": phone,
      if (email != null) "email": email,
      if (password != null) "password": password,
      if (avatar != null) "avatar": avatar,
    };
  }
}
