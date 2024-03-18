import 'dart:convert';
import 'package:http/http.dart' as http;

//invalidotpexception
class OTPService{
  final String baseUrl = 'http://35.208.97.167:3000/api/otp';

  Future<void> generateOTP(String email)async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/generate"),
        body: {'email': email},
      );

      if (response.statusCode != 200) {
        final responseBody = json.decode(response.body);
        final errorMessage = responseBody['message'] ?? 'Unknown Error';
        throw Exception('$errorMessage');
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

  Future<void> verifyOTP(String email, String otp)async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/verify"),
        body: {
          'email': email,
          'otp': otp
        },
      );

      if (response.statusCode != 200) {
        final responseBody = json.decode(response.body);
        final errorMessage = responseBody['message'] ?? 'Unknown Error';
        throw Exception('$errorMessage');
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

}