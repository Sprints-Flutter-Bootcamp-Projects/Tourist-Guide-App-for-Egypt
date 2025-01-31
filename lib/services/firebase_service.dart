import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_guide/models/firebase_models/firebase_user.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> firebaseLogout() async {
    try {
      await _auth.signOut();
      print("User logged out successfully.");
    } catch (e) {
      print("Error logging out: $e");
    }
  }

  Future<FirebaseUser?> fetchCurrentUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection("users")
            .doc(firebaseUser.uid)
            .get();
        if (doc.exists) {
          return FirebaseUser.fromFirestore(doc);
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
    return null;
  }

  Future<FirebaseUser?> firebaseSignUp({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Retrieve the UID from Firebase Auth
      String uid = userCredential.user!.uid;

      // Create FirebaseUser object
      FirebaseUser newUser = FirebaseUser(
        id: uid, // Assign UID
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        password: password,
      );

      // Save to Firestore using UID as document ID
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid) // Save under UID
          .set(newUser.toFirestore());

      // Convert Firebase User to your FirebaseUser model
      final firebaseUser = FirebaseUser(
        email: userCredential.user?.email,
      );

      print("User registered and saved to Firestore successfully!");
      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        default:
          errorMessage = 'An unknown error occurred.';
      }
      print(errorMessage);
      return null;
    } catch (e) {
      print("Error signing up: $e");
    }
    return null;
  }

  Future<FirebaseUser?> firebaseSignIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Convert Firebase User to your FirebaseUser model
      final firebaseUser = FirebaseUser(
        email: userCredential.user?.email,
      );

      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided for that user.';
          break;
        default:
          errorMessage = 'An unknown error occurred.';
      }
      print(errorMessage);
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
