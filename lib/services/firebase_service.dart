import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_guide/models/firebase_models/firebase_user.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser?> firebaseSignUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Convert Firebase User to your FirebaseUser model
      final firebaseUser = FirebaseUser(
        // uid: credential.user?.uid ?? '',
        email: credential.user?.email,
      );

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
      print('Error: $e');
      return null;
    }
  }

  Future<FirebaseUser?> firebaseSignIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Convert Firebase User to your FirebaseUser model
      final firebaseUser = FirebaseUser(
        email: credential.user?.email,
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
