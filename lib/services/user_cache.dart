import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist_guide/models/user.dart';

class UserCache {
  static const String _key = 'cached_users';

  // Save users to SharedPreferences
  static Future<void> saveUsers(List<APIUser> users) async {
    final prefs = await SharedPreferences.getInstance();
    final userJsonList =
        users.map((user) => jsonEncode(user.toJson())).toList();
    await prefs.setStringList(_key, userJsonList);
  }

  // Load users from SharedPreferences
  static Future<List<APIUser>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final userJsonList = prefs.getStringList(_key) ?? [];
    return userJsonList
        .map((userJson) => APIUser.fromJson(jsonDecode(userJson)))
        .toList();
  }

  // Clear cached users
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    if (kDebugMode) {
      print("deleted");
    }
  }
}
