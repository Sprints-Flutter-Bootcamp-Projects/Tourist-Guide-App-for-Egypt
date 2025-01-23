import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tourist_guide/models/place_model.dart';

class PlacesController {
  Future<List<Place>> fetchSuggestedPlaces({int start = 0, int limit = 3}) async {
    final String response =
        await rootBundle.loadString('data_source/places_data.json');
    final data = json.decode(response);
    final List<dynamic> suggestedPlacesJson = data['suggested_places'];
    return suggestedPlacesJson
        .skip(start)
        .take(limit)
        .map((json) => Place.fromJson(json))
        .toList();
  }

  Future<List<Place>> fetchPopularPlaces({int start = 0, int limit = 3}) async {
    final String response =
        await rootBundle.loadString('data_source/places_data.json');
    final data = json.decode(response);
    final List<dynamic> popularPlacesJson = data['popular_places'];
    return popularPlacesJson
        .skip(start)
        .take(limit)
        .map((json) => Place.fromJson(json))
        .toList();
  }
}