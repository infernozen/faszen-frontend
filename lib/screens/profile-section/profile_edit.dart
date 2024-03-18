import 'package:faszen/screens/profile-section/profile_information.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final profileInfoController = TextEditingController();
  final shoppingSettingController = TextEditingController();
  final languageController = TextEditingController();
  final notificationController = TextEditingController();
  final locationController = TextEditingController();
  final termsOfUseController = TextEditingController();
  final aboutThisVersionController = TextEditingController();

  String profileInfo = '';
  String shoppingSetting = '';
  String language = '';
  bool notification = false;
  bool location = false;
  String termsOfUse = '';
  String aboutThisVersion = '';

  // Define a method to update the menu option values when the text fields change
  void updateMenuValues() {
    setState(() {
      profileInfo = profileInfoController.text;
      shoppingSetting = shoppingSettingController.text;
      language = languageController.text;
      notification = notificationController.text == 'on';
      location = locationController.text == 'on';
      termsOfUse = termsOfUseController.text;
      aboutThisVersion = aboutThisVersionController.text;
    });
  }

  void validateMenuValues() {
    if (profileInfo.isEmpty ||
        shoppingSetting.isEmpty ||
        language.isEmpty ||
        termsOfUse.isEmpty ||
        aboutThisVersion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all the fields'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Show a snackbar message with a success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT PROFILE',style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.w500)),
        centerTitle: true,
        leading: Center(
          child: IconButton(icon: Icon(Icons.chevron_left_sharp, size: MediaQuery.of(context).size.height * 0.045),
            onPressed: () {
              Navigator.pop(context); // Navigate back when pressed
            },
          ),
        ),
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: ListView(
          children: [
            SizedBox(height: maxH * 0.05),

            ListTile(
              title: const Text('Profile Information',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18, 
                  fontWeight: FontWeight.w600
                )
              ),
              tileColor: Colors.white,
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileInformation(),
                  ),
                );
              },
            ),
            
            SizedBox(height: maxH * 0.04), 
            
            ListTile(
              title: const Text('Shopping Setting',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18, 
                  fontWeight: FontWeight.w600
                )
              ),
              tileColor: Colors.white,
              shape: const Border(bottom: BorderSide(color: Colors.grey)),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                // Navigate to the shopping setting screen
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ShoppingSettingPage(),
                //   ),
                // );
              },
            ),
            
            ListTile(
              title: const Text('Language',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18, 
                  fontWeight: FontWeight.w600
                )
              ),
              shape: const Border(bottom: BorderSide(color: Colors.grey)),
              tileColor: Colors.white,
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                // Navigate to the language screen
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const LanguagePage(),
                //   ),
                // );
              },
            ),
            
            ListTile(   
              title: const Text('Notification',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18, 
                  fontWeight: FontWeight.w600
                )
              ),
              tileColor: Colors.white,
              shape: const Border(bottom: BorderSide(color: Colors.grey)),
              trailing: Switch(
                activeColor: const Color.fromRGBO(35, 188, 96, 1),
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.white,
                value: notification,
                onChanged: (value) {
                  setState(() {
                    notification = value;
                  });
                },
              ),
            ),
            
            ListTile(
              title: const Text('Location',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18, 
                  fontWeight: FontWeight.w600
                )
              ),
              tileColor: Colors.white,
              trailing: Switch(
                activeColor: const Color.fromRGBO(35, 188, 96, 1),
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.white,
                value: location,
                onChanged: (value) {
                  setState(() {
                    location = value;
                  });
                },
              ),
            ),
            
            SizedBox(height: maxH * 0.04),          
            
            ListTile(
              title: const Text('Terms of use',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18, 
                  fontWeight: FontWeight.w600
                )
              ),
              tileColor: Colors.white,
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              shape: const Border(bottom: BorderSide(color: Colors.grey)),
              onTap: () {
                // Navigate to the terms of use screen
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const TermsOfUsePage(),
                //   ),
                // );
              },
            ),
            ListTile(
              title: const Text('About this version',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18, 
                  fontWeight: FontWeight.w600
                )
              ),
              tileColor: Colors.white,
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                // Navigate to the about this version screen
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const AboutThisVersionPage(),
                //   ),
                // );
              },
            ),
                  
            SizedBox(height: maxH * 0.03),
            ListTile(
              title: const Text('Delete Account', 
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(235, 13, 13, 1),
                ),
              ),
              trailing: const Icon(Icons.warning_amber_sharp, color: Color.fromRGBO(235, 13, 13, 1), size: 32),
              tileColor: Colors.white,
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
