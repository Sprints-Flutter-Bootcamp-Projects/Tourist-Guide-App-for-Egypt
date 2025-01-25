import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tourist_guide/models/governorate_model.dart';

class GovernorateController {
  Future<List<Governorate>> fetchGovernorates() async {
    final String response = await rootBundle.loadString('data_source/gov_data.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Governorate.fromJson(json)).toList();
  }
}
