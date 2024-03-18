import 'dart:convert';

import 'package:faszen/services/storage_service.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://35.208.97.167:3000/api/auth';
  StorageService storage = StorageService();

  Future<bool> checkEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/checkEmail"),
        body: {'email': email},
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        return false;
      } else {
        throw Exception('Failed to check email: ${response.statusCode}');
      }
    } catch (error) {
      if (error is http.ClientException) {
        throw Exception('Network Error: Please Try again later!!');
      } 
      else {
        rethrow;
      }
    }
  }

  Future<bool> signIn(String email, String password)async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/signin"),
        body: {
          'email': email,
          'password': password
        },
      );

      if (response.statusCode == 200) {
        storage.saveUserData(json.decode(response.body));
        return true;
      } else if (response.statusCode == 401) {
        return false;
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (error) {
      if (error is http.ClientException) {
        throw Exception('Network Error: Please Try again later!!');
      } 
      else {
        rethrow;
      }
    }
  }

  Future<bool> signUp(String email, String password, String firstName, String lastName, String otp)async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/signup"),
        body: {
          'email': email,
          'password': password,
          'firstname': firstName,
          'lastname': lastName,
          'otp' : otp
        },
      );

      if (response.statusCode == 200) {
        storage.saveUserData(json.decode(response.body));
        return true;
      } else if (response.statusCode == 401) {
        return false;
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (error) {
      if (error is http.ClientException) {
        throw Exception('Network Error: Please Try again later!!');
      } 
      else {
        rethrow;
      }
    }
  }

  Future<bool> changePassword(String email, String password)async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/changePassword"),
        body: {
          'email': email,
          'password': password
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (error) {
      if (error is http.ClientException) {
        throw Exception('Network Error: Please Try again later!!');
      } 
      else {
        rethrow;
      }
    }
  }

  Future<bool> verifyToken(String token)async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/verifyToken'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }catch(e){
      throw Exception("Something went wrong!!");
    }
  }
}