import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pavlok/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://api.pavlok.com/api/v5/';

  Future<http.Response> registerUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl + 'users/'),
      body: jsonEncode({
        'user': {'email': email, 'password': password}
      }),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Host': 'api.pavlok.com'
      },
    );
    return response;
  }

  Future<http.Response> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl + 'users/login'),
      body: jsonEncode({
        'user': {'email': email, 'password': password}
      }),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Host': 'api.pavlok.com'
      },
    );
    return response;
  }

  Future<http.Response> getUser(String token) async {
    final response = await http.get(
      Uri.parse(baseUrl + 'user/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Host': 'api.pavlok.com'
      },
    );
    return response;
  }

  Future<http.Response> updateUser(
    String token, {
    String? username,
    String? email,
    String? firstName,
    String? lastName,
  }) async {
    // Nested 'user' object
    final Map<String, dynamic> userMap = {};

    if (username != null) {
      userMap['username'] = username;
    }

    if (email != null) {
      userMap['email'] = email;
    }

    if (firstName != null) {
      userMap['first_name'] = firstName;
    }

    if (lastName != null) {
      userMap['last_name'] = lastName;
    }

    // Wrapping the userMap inside the requestData
    final Map<String, dynamic> requestData = {
      'user': userMap,
    };

    final response = await http.put(
      Uri.parse(baseUrl + 'user/'),
      body: jsonEncode(requestData),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Host': 'api.pavlok.com'
      },
    );
    return response;
  }

  Future<http.Response> createStimulus(
    String type,
    int value,
    String token,
    String? reason,
  ) async {
    final response = await http.post(
      Uri.parse(baseUrl + 'stimulus/send'),
      body: jsonEncode({
        'stimulus': {
          'stimulusType': type,
          'stimulusValue': value,
          'reason': reason
        }
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Host': 'api.pavlok.com'
      },
    );
    return response;
  }

  Future<http.Response> listAllStimuli(String token) async {
    final response = await http.get(
      Uri.parse(baseUrl + 'stimulus/sent/me'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

  Future<void> saveUserData(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString('user_data', userJson);
  }

  Future<void> clearUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<User?> checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userDataString = prefs.getString('user_data') ?? '';

    if (userDataString.isNotEmpty) {
      final Map<String, dynamic> userData = jsonDecode(userDataString);
      return User.fromJson(userData);
    } else {
      return null;
    }
  }
}
