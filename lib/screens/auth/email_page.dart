import 'dart:convert';
import 'package:faszen/screens/auth/member_page.dart';
import 'package:faszen/screens/auth/login_page.dart';
import 'package:faszen/screens/init_page.dart';
import 'package:faszen/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';


class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  TextEditingController emailcontroller = TextEditingController();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  final AuthService _authService = AuthService();
  bool isValid = true;

  Future<void> handleSubmitted(context) async{
    final email = emailcontroller.text.trim();
    try {
      final emailExists = await _authService.checkEmail(email);

      if (emailExists) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(email: email,),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MemberPage(email: email),
          ),
        ); 
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$error")),
      );
    }
  }

  void _signInGoogle(context) async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    String backendUrl = 'http://35.208.97.167:3000/api/auth/getToken';

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        // for profile creation       
        http.post(
        Uri.parse(backendUrl),
        body: {
          'email': googleUser.email,
        },
      ).then((response) {       
        if (response.statusCode == 200) {
          saveUserData(json.decode(response.body));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InitPage(),
            ),
          );
        }
        else{
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemberPage(email: googleUser.email,),
            ),
          );
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error $error")),
        );
    });  
    }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error $error")),
        );
    }
  }

  void _signInFacebook(context) async {
    final fb = FacebookLogin();
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken? accessToken = res.accessToken;
        print('Access token: ${accessToken?.token}');

        final profile = await fb.getUserProfile();
        print('Hello, ${profile?.name}! You ID: ${profile?.userId}');

        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        final email = await fb.getUserEmail();
        if (email != null) {
          print('And your email is $email');
        }

        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        print('Error while log in: ${res.error}');
        break;
    }
  }

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              SizedBox(
                width: 0.9 * width,
                child: Text(
                  "Enter your email to join us or sign in",
                  style: GoogleFonts.poppins(
                      fontSize: 30, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 0.9 * width,
                child: TextFormField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    // ignore: dead_code
                    errorText: isValid ? null : "Invalid email format",
                    labelText: "Your Email",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.mail),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 0.9 * width,
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'By clicking "Continue", you agree to our ',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            decoration: TextDecoration.none
                          )),
                      TextSpan(
                        text: "Privacy Policies",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                          decorationThickness: 1.0,
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: " and ",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          decoration: TextDecoration.none
                        ),
                      ),
                      TextSpan(
                        text: "terms of use",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                          decorationThickness: 1.0,
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 0.9 * width,
                child: ElevatedButton(
                  onPressed: () {
                    if (emailcontroller.text.isNotEmpty) {
                      if(!emailcontroller.text.endsWith("@gmail.com")){
                        setState(() {
                          isValid = false;
                        });
                      }
                      else{
                        setState(() {
                          isValid = true;
                        });
                        handleSubmitted(context);
                      }
                    }
                  },
                  child: const Text("CONTINUE"),
                ),
              ),
              const Spacer(),
              Text(
                "Or continue with",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      _signInGoogle(context);
                    },
                    child: Image.asset(
                      "assets/Picture1.png",
                      height: 48,
                      width: 48,
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
                      googleSignIn.signOut();
                      _signInFacebook(context);
                    },
                    child: Image.asset(
                      "assets/Picture2.png",
                      height: 48,
                      width: 48,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Image.asset(
                    "assets/Picture3.png",
                    height: 48,
                    width: 48,
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 30),
            ]),
      ),
    );
  }
}