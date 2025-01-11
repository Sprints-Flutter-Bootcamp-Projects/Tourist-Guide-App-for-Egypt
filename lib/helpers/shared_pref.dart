import 'dart:convert'; // For JSON encoding and decoding
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Save user data as a JSON string
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(userData); // Convert map to JSON string
    await prefs.setString('user_data', jsonData);
  }

  // Retrieve user data as a Map
  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('user_data');
    if (jsonData != null) {
      return jsonDecode(jsonData); // Convert JSON string back to map
    }
    return null;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
