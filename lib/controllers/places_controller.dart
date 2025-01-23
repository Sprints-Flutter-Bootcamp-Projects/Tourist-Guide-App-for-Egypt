// filepath: /D:/Sprints/Module 2/Tourist-Guide-App-for-Egypt/lib/controllers/places_controller.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tourist_guide/helpers/shared_pref.dart';
import 'package:tourist_guide/models/place_model.dart';

class PlacesController {
  Future<List<Place>> fetchSuggestedPlaces() async {
    final String response =
        await rootBundle.loadString('data_source/places_data.json');
    final data = json.decode(response);
    final List<dynamic> suggestedPlacesJson = data['suggested_places'];
    return suggestedPlacesJson.map((json) => Place.fromJson(json)).toList();
  }

  Future<List<Place>> fetchPopularPlaces() async {
    final String response =
        await rootBundle.loadString('data_source/places_data.json');
    final data = json.decode(response);
    final List<dynamic> popularPlacesJson = data['popular_places'];
    return popularPlacesJson.map((json) => Place.fromJson(json)).toList();
  }

 
}
