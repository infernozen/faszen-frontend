import 'package:faszen/screens/init_page.dart';
import 'package:faszen/services/auth_service.dart';
import 'package:faszen/services/otp_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:faszen/screens/auth/otp_page.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  final String email;
  const LoginPage({required this.email, super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  final AuthService _authService = AuthService();
  final OTPService _otpService = OTPService();
  bool isPasswordVisible = false;
  bool isValid = true;

  Future<void> generateOTP(context)async {
    try {
      await _otpService.generateOTP(widget.email);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$error")),
      );
    }
  }

  Future<void> handleSubmitted(context)async {
    String password = passwordController.text;
    try {
      final isAuthenticated = await _authService.signIn(widget.email, password);

      if (isAuthenticated) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => InitPage()),
          (Route<dynamic> route) => false,
        );

      } else {
        setState(() {
          isValid = false;
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Row(
            children: [
              SizedBox(width: 20),
              Text("Yay! We found you", style: TextStyle(fontSize: 30)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(widget.email),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Change",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 0.9 * width,
            child: TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                errorText: isValid ? null : "Invalid Password!!",
                labelText: "PASSWORD",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.lock),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    child: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 0.9 * width,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () {
                handleSubmitted(context);
              },
              child: const Text("LOGIN", style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {             
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OtpPage(email: widget.email)),
              );
              generateOTP(context);
            },
            child: const Text("FORGOT PASSWORD?"),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
