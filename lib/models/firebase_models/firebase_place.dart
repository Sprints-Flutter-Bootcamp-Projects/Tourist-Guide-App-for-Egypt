import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePlace {
  final String? id; // Document ID from Firestore
  final String name;
  final String location;
  final String image;
  final bool addedToFavorite;

  FirebasePlace({
    this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.addedToFavorite,
  });

  // Factory constructor to create a FirebasePlace from Firestore
  factory FirebasePlace.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return FirebasePlace(
      id: snapshot.id, // Assign document ID
      name: data?['name'] ?? '',
      location: data?['location'] ?? '',
      image: data?['image'] ?? '',
      addedToFavorite: data?['added_to_favorite'] ?? false,
    );
  }

  // Convert FirebasePlace to a Firestore-compatible Map
  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id, // Ensure document ID is stored
      "name": name,
      "location": location,
      "image": image,
      "added_to_favorite": addedToFavorite,
    };
  }
}
