import 'dart:async';
import 'package:faszen/screens/init_page.dart';
import 'package:faszen/services/auth_service.dart';
import 'package:faszen/services/otp_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:faszen/screens/auth/email_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class MemberPage extends StatefulWidget {
  final String email;
  const MemberPage({required this.email, super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  final OTPService _otpService = OTPService(); 
  TextEditingController codecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  bool isPasswordEmpty = true;
  bool isVisible = false;
   

  Future<void> _generateOTP(context)async {
    try {
      await _otpService.generateOTP(widget.email);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$error")),
      );
    }
  }

  bool isLengthValid(String value) {
    return value.length >= 8;
  }

  bool hasUpperCase(String value) {
    return value.contains(RegExp(r'[A-Z]'));
  }

  bool hasLowerCase(String value) {
    return value.contains(RegExp(r'[a-z]'));
  }

  bool hasSymbol(String value) {
    return value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  bool hasNoWhiteSpace(String value) {
    return !value.contains(RegExp(r'\s'));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                "Now become our member",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(children: [
            const SizedBox(width: 20),
            SizedBox(
              width: 0.4 * width,
              child: TextFormField(
                controller: firstnamecontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "First name",
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 0.4 * width,
              child: TextFormField(
                controller: lastnamecontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Last name",
                ),
              ),
            ),
            const SizedBox(width: 20),
          ]),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              SizedBox(
                width: 0.9 * width,
                child: TextFormField(
                  controller: passwordcontroller,
                  obscureText: !isVisible,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: "Password",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        child: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                "Must be at least 8 characters",
                style: TextStyle(
                  color: passwordcontroller.text.isEmpty
                      ? Colors.grey
                      : isLengthValid(passwordcontroller.text)
                          ? Colors.green
                          : Colors.red,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                "Must contain UPPERCASE letter",
                style: TextStyle(
                  color: passwordcontroller.text.isEmpty
                      ? Colors.grey
                      : hasUpperCase(passwordcontroller.text)
                          ? Colors.green
                          : Colors.red,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                "Must contain lowercase letter",
                style: TextStyle(
                  color: passwordcontroller.text.isEmpty
                      ? Colors.grey
                      : hasLowerCase(passwordcontroller.text)
                          ? Colors.green
                          : Colors.red,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                "Must contain at least 1 symbol character",
                style: TextStyle(
                  color: passwordcontroller.text.isEmpty
                      ? Colors.grey
                      : hasSymbol(passwordcontroller.text)
                          ? Colors.green
                          : Colors.red,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                "Must not contain any whitespace",
                style: TextStyle(
                  color: passwordcontroller.text.isEmpty
                      ? Colors.grey
                      : hasNoWhiteSpace(passwordcontroller.text)
                          ? Colors.green
                          : Colors.red,
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 0.9 * width,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: const <TextSpan>[
                  TextSpan(
                    text: """By clicking "Continue", you agree to our """,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                      decoration: TextDecoration.none
                    ),
                  ),
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
                    text: "Terms of Use",
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
                if (firstnamecontroller.text.isNotEmpty &&
                    lastnamecontroller.text.isNotEmpty &&
                    passwordcontroller.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MemberOtpPage(email: widget.email, firstname: firstnamecontroller.text, 
                                                          lastname:lastnamecontroller.text, password:passwordcontroller.text)),
                  );
                  _generateOTP(context);                
                }
              },
              child: const Text("CREATE MY ACCOUNT"),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class MemberOtpPage extends StatefulWidget { 
  final String email,firstname,lastname,password;
  
  const MemberOtpPage({required this.email, required this.firstname, required this.lastname, required this.password, super.key});
  @override
  State<MemberOtpPage> createState() => _MemberOtpPageState();
}

class _MemberOtpPageState extends State<MemberOtpPage> {
  late TextEditingController _otpController;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  final OTPService _otpService = OTPService();
  final AuthService _authService = AuthService();
  int _resendTimer = 60;
  bool _showResendButton = false;
  late Timer _timer;

  Future<void> _generateOTP(context)async {
    try {
      await _otpService.generateOTP(widget.email);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$error")),
      );
    }
  }

  Future<void> _onOtpSubmitted(String otp, context)async {
    try {
      final isAuthenticated = await _authService.signUp(widget.email, widget.password, widget.firstname, widget.lastname, otp);

      if (isAuthenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InitPage(showProfileEditHelp: false),
          ),
        );
      } else {
        //OTP is invalid
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$error")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _startResendTimer();
  }

  void _startResendTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) { // Assign the Timer instance to _timer
      setState(() {
        if (_resendTimer < 1) {
          timer.cancel();
          // Reset the timer and enable resend button
          _resendTimer = 60;
          _showResendButton = true; // Show resend button
        } else {
          _resendTimer--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ENTER OTP"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                "We've send a code to you",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(widget.email,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const EmailPage()));
                },
                child: const Text("Change"),
              )
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 85.0),
            child: PinCodeTextField(
              appContext: context,
              keyboardType: TextInputType.number,
              length: 4,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.circle,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 50,
                fieldWidth: 50,
                activeColor: Colors.blue,
                activeFillColor: Colors.blue.withOpacity(0.1),
                inactiveColor: Colors.grey,
                selectedColor: Colors.blue,
                selectedFillColor: Colors.blue.withOpacity(0.1),
              ),
              onChanged: (value) {
                _otpController.text = value.replaceAll(RegExp(r'[^0-9]'), '');
              },
              onCompleted: (value) => _onOtpSubmitted(_otpController.text, context),
            ),
          ),
          const SizedBox(height: 20),
          _showResendButton
              ? ElevatedButton(
                  onPressed: () {
                    _generateOTP(context);
                    setState(() {
                      _resendTimer = 60;
                      _showResendButton = false;
                    });
                  },
                  child: const Text("Resend OTP"),
                )
              : Text("Resend OTP in $_resendTimer seconds"),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer.cancel();
    super.dispose();
  }
}
