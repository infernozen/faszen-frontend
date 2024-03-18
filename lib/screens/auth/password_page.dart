import 'package:faszen/screens/auth/email_page.dart';
import 'package:faszen/services/auth_service.dart';
import 'package:flutter/material.dart';

class PasswordPage extends StatefulWidget {
  final String email;
  
  const PasswordPage({required this.email,super.key});

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypepasswordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isMatch = false;

  Future<void> changePassword(newPassword, context)async {
    try {
      final isChanged = await _authService.changePassword(widget.email, newPassword);

      if (isChanged) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EmailPage(),
          ),
        );
        _showMyDialog(context);
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$error")),
      );
    }
  }

  void _showMyDialog(context){
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password Change Successful'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your password has been changed successfully!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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

  bool isVisible = false;
  bool isRetypeVisible = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("CHANGE YOUR PASSWORD"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              SizedBox(
                width: 0.9 * width,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: !isVisible,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: "New Password",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.lock),
                    ),
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
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                "Must be at least 8 characters",
                style: TextStyle(
                  color: passwordController.text.isEmpty
                      ? Colors.grey
                      : isLengthValid(passwordController.text)
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
                  color: passwordController.text.isEmpty
                      ? Colors.grey
                      : hasUpperCase(passwordController.text)
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
                  color: passwordController.text.isEmpty
                      ? Colors.grey
                      : hasLowerCase(passwordController.text)
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
                  color: passwordController.text.isEmpty
                      ? Colors.grey
                      : hasSymbol(passwordController.text)
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
                  color: passwordController.text.isEmpty
                      ? Colors.grey
                      : hasNoWhiteSpace(passwordController.text)
                          ? Colors.green
                          : Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              SizedBox(
                width: 0.9 * width,
                child: TextFormField(
                  controller: retypepasswordController,
                  obscureText: !isRetypeVisible,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    errorText: isMatch ? "Password didn't match" : null,
                    border: const UnderlineInputBorder(),
                    labelText: "Confirm Password",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.lock),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isRetypeVisible = !isRetypeVisible;
                          });
                        },
                        child: Icon(
                          isRetypeVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
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
          const SizedBox(height: 20),
          const Spacer(),
          SizedBox(
            width: 0.9 * width,
            child: ElevatedButton(
              child: const Text("CHANGE MY PASSWORD"),
              onPressed: () {
                var password = passwordController.text;
                if (password == retypepasswordController.text && hasLowerCase(password) && hasNoWhiteSpace(password)
                    && hasUpperCase(password) && isLengthValid(password) && hasSymbol(password)
                ) {
                  isMatch = false;
                  changePassword(passwordController.text, context);
                } else if (passwordController.text !=
                        retypepasswordController.text &&
                    passwordController.text.isNotEmpty &&
                    retypepasswordController.text.isNotEmpty) {
                  setState(() {
                    isMatch = true;
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}