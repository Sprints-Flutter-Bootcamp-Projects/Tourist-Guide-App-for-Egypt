// To parse this JSON data, do
//
//     final governorate = governorateFromJson(jsonString);

import 'dart:convert';

import 'package:tourist_guide/models/landmark_model.dart';

Governorate governorateFromJson(String str) =>
    Governorate.fromJson(json.decode(str));

String governorateToJson(Governorate data) => json.encode(data.toJson());

class Governorate {
  String governorate;
  String governorateImage;
  List<Landmark> landmarks;

  Governorate({
    required this.governorate,
    required this.governorateImage,
    required this.landmarks,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) => Governorate(
        governorate: json["governorate"],
        governorateImage: json["governorate_image"],
        landmarks: List<Landmark>.from(
            json["landmarks"].map((x) => Landmark.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "governorate": governorate,
        "governorate_image": governorateImage,
        "landmarks": List<dynamic>.from(landmarks.map((x) => x.toJson())),
      };
}
