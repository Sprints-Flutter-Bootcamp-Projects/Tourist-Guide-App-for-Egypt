import 'package:dio/dio.dart';
import 'package:tourist_guide/models/user.dart';
import 'package:tourist_guide/services/user_cache.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://reqres.in/api'));

  // Fetch users with caching
  Future<List<APIUser>> getUsers({required bool allowCache}) async {
    try {
      // Try to load cached users first
      if (allowCache) {
        final cachedUsers = await UserCache.getUsers();
        if (cachedUsers.isNotEmpty) {
          return cachedUsers;
        }
      }

      // If no cached data, fetch from API
      final response = await _dio.get('/users');
      final users = (response.data['data'] as List)
          .map((user) => APIUser.fromJson(user))
          .toList();

      // Save fetched users to cache
      await UserCache.saveUsers(users);
      return users;
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  // Create a new user
  Future<APIUser> createUser(APIUser user) async {
    try {
      final response = await _dio.post('/users', data: user.toJson());
      final newUser = APIUser.fromJson(response.data);

      // Update cache with the new user
      final cachedUsers = await UserCache.getUsers();
      cachedUsers.add(newUser);
      await UserCache.saveUsers(cachedUsers);

      return newUser;
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  // Update a user
  Future<APIUser> updateUser(APIUser user) async {
    try {
      final response = await _dio.put('/users/${user.id}', data: user.toJson());
      final updatedUser = APIUser.fromJson(response.data);

      // Update cache with the updated user
      final cachedUsers = await UserCache.getUsers();
      final index = cachedUsers.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        cachedUsers[index] = updatedUser;
        await UserCache.saveUsers(cachedUsers);
      }

      return updatedUser;
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<APIUser> updateUserAvatar(APIUser user, String avatar) async {
    try {
      final response = await _dio.put('/users/${user.id}', data: user.toJson());
      final updatedUser = APIUser.fromJson(response.data);

      // Update cache with the updated user
      final List<APIUser> cachedUsers = await UserCache.getUsers();
      final index = cachedUsers.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        cachedUsers[index].avatar = avatar;
        await UserCache.saveUsers(cachedUsers);
      }

      return updatedUser;
    } catch (e) {
      throw Exception('Failed to update user\'s avatar: $e');
    }
  }

  // Delete a user
  Future<void> deleteUser(String id) async {
    try {
      await _dio.delete('/users/$id');

      // Remove the user from the cache
      final cachedUsers = await UserCache.getUsers();
      cachedUsers.removeWhere((user) => user.id == id);
      await UserCache.saveUsers(cachedUsers);
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
