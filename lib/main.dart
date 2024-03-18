import 'package:faszen/screens/auth/email_page.dart';
import 'package:faszen/screens/init_page.dart';
import 'package:faszen/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const FlutterSecureStorage storage = FlutterSecureStorage();
  final AuthService authService = AuthService();

  String? jwtToken = await storage.read(key: 'token') ?? "N/A";
  bool isValidToken = false;

  try {
    isValidToken = await authService.verifyToken(jwtToken);
  } catch (e) {
    showErrorMessage('Error occurred. Please try again later.');
  }

  runApp(MyApp(
    jwtToken: jwtToken,
    isValidToken: isValidToken,
  ));
}

class MyApp extends StatelessWidget {
  final String jwtToken;
  final bool isValidToken;

  const MyApp({super.key, required this.jwtToken, required this.isValidToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isValidToken ? InitPage() : const EmailPage(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },
    );
  }
}


void showErrorMessage(String message) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
