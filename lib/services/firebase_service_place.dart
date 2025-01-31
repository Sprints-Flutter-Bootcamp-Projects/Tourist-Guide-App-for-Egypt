import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourist_guide/models/firebase_models/firebase_place.dart';
import 'package:tourist_guide/models/place_model.dart';
import 'package:tourist_guide/services/firebase_service_auth.dart';

class FirebaseServicePlace {
  // functions for working with Places old mode until we switch to firebase for all

  Future<void> addPlaceToFavorites(String userId, Place place) async {
    final userFavoritesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(place.name); // Use place name as document ID just for now

    await userFavoritesRef.set(place.toJson());
    print("Place added to favorites!");
  }

  Future<void> removePlaceFromFavorites(String userId, String placeId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(placeId)
        .delete();

    print("Place removed from favorites!");
  }

  Future<bool> isPlaceInFavorites(String userId, String placeId) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(placeId)
        .get();

    return doc.exists;
  }

  // ----------------------------------------------------------------------

  // defined function for when we switch to firebase places model

  Future<void> addPlaceToFavorites_fb(
      String userId, FirebasePlace place) async {
    final userFavoritesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(place.id); // Use place ID as document ID

    await userFavoritesRef.set(place.toFirestore());

    print("Place added to favorites!");
  }

  Future<void> removePlaceFromFavorites_fb(
      String userId, String placeId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(placeId)
        .delete();

    print("Place removed from favorites!");
  }

  Stream<List<FirebasePlace>> fetchUserFavorites(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FirebasePlace.fromFirestore(doc))
            .toList());
  }

  Stream<List<FirebasePlace>> fetchPlaces() {
    return FirebaseFirestore.instance.collection('places').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => FirebasePlace.fromFirestore(doc))
              .toList(),
        );
  }

  Future<bool> isPlaceInFavorites_fb(String userId, String placeId) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(placeId)
        .get();

    return doc.exists;
  }
}
