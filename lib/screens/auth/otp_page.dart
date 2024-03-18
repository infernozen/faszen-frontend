import 'dart:async';
import 'package:faszen/screens/auth/password_page.dart';
import 'package:faszen/services/otp_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:faszen/screens/auth/email_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatefulWidget {
  final String email;

  const OtpPage({required this.email, super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late TextEditingController _otpController;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  final OTPService _otpService = OTPService();
  int _resendTimer = 60;
  bool _showResendButton = false;
  late Timer _timer;

  Future<void> generateOTP(context)async {
    try {
      await _otpService.generateOTP(widget.email);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$error")),
      );
    }
  }

  Future<void> _onOtpSubmitted(String otp, context) async{
    try {
      await _otpService.verifyOTP(widget.email, otp);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PasswordPage(email: widget.email,),
        ),
      );
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
                    generateOTP(context);
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

