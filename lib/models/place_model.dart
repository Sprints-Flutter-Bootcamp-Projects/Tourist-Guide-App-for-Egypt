// To parse this JSON data, do
//
//     final place = placeFromJson(jsonString);

import 'dart:convert';

Place placeFromJson(String str) => Place.fromJson(json.decode(str));

String placeToJson(Place data) => json.encode(data.toJson());

class Place {
  String name;
  String location;
  String image;
  bool addedToFavorite;

  Place({
    required this.name,
    required this.location,
    required this.image,
    required this.addedToFavorite,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        name: json["name"],
        location: json["location"],
        image: json["image"],
        addedToFavorite: json["added_to_favorite"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "image": image,
        "added_to_favorite": addedToFavorite,
      };
}
