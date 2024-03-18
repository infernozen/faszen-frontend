import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService{
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> saveUserData(Map<String, dynamic> responseData) async {
    final token = responseData['data']['token'];
    final email = responseData['data']['email'];
    final firstName = responseData['data']['firstname'];
    final lastName = responseData['data']['lastname'];
    final creationTime = responseData['data']['creationTime'];

    await storage.write(key: 'token', value: token);
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'firstName', value: firstName);
    await storage.write(key: 'lastName', value: lastName);
    await storage.write(key: 'creationTime', value: creationTime);
  }

  Future<String?> getFirstname() async {
    return storage.read(key: 'firstName');
  }

  Future<String?> getLastname() async {
    return storage.read(key: 'lastName');
  }

  Future<String?> getCreationTime() async {
    return storage.read(key: 'creationTime');
  }

  Future<String?> getEmail() async {
    return storage.read(key: 'email');
  }

  Future<void> deleteAll() async{
    await storage.deleteAll();
  }
}