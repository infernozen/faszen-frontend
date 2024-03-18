import 'dart:io';
import 'package:faszen/screens/auth/email_page.dart';
import 'package:faszen/screens/profile-section/profile_edit.dart';
import 'package:faszen/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Image? _imageFile;
  String profileName = '';
  String creationDate = 'dd.mm.yyyy';
  final StorageService _storageService = StorageService();
  

  Future<void> createDirectory() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final subDirectory = Directory('${directory.path}/faszen');

      if (!(await subDirectory.exists())) {
        await subDirectory.create(recursive: true);
      }
    } catch (e) {
      print('Error creating directory: $e');
    }
  }

  Future<void> clearAppStorage() async {
    try {
      // Get the app's document directory
      final appDir = await getApplicationDocumentsDirectory();
      // Get a list of all files and directories in the app's document directory
      final dirContents = appDir.listSync(recursive: true);

      // Delete each file and directory
      for (var entity in dirContents) {
        if (entity is File) {
          await entity.delete();
        } else if (entity is Directory) {
          await entity.delete(recursive: true);
        }
      }

      print('App storage cleared successfully');
    } catch (e) {
      print('Error clearing app storage: $e');
    }
  }

  Future<void> removeAllTokens(context) async {
    await _storageService.deleteAll();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Credentials are removed!!")),
    );
  }

  Future<File?> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = Image.file(File(pickedFile.path),
            height: 100, width: 100, fit: BoxFit.cover);
      });

      await createDirectory();
      final directory = await getApplicationDocumentsDirectory();
      String imagePath = '${directory.path}/faszen';
      const String fileName = 'profile_image.jpg';

      // Copy the picked file to the desired directory
      final File newImage =
          await File(pickedFile.path).copy('$imagePath/$fileName');

      return newImage;
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final firstName = await _storageService.getFirstname() ?? '';
    final lastName = await _storageService.getLastname() ?? '';
    setState(() {
      profileName =
          '${_capitalizeFirstLetter(firstName)} ${_capitalizeFirstLetter(lastName)}';
    });
    final date = await _storageService.getCreationTime();
    if (date != null) {
      setState(() {
        creationDate = date;
      });
    }

    final directory = await getApplicationDocumentsDirectory();
    String imagePath = '${directory.path}/faszen/profile_image.jpg';
    if (await File(imagePath).exists()) {
      setState(() {
        _imageFile = Image.file(File(imagePath),
            height: 100, width: 100, fit: BoxFit.cover);
      });
    } else {
      setState(() {
        _imageFile = Image.asset('assets/profile-pic.jpg',
            height: 100, width: 100, fit: BoxFit.cover);
      });
    }
  }

  String _capitalizeFirstLetter(String input) {
    if (input.isEmpty) return '';
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height *
                0.30, // 30% of screen height
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(40))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Stack(
                      children: [
                        Container(
                          width: 125,
                          height: 125,
                          color: Colors.black,
                          child: _imageFile != null
                              ? _imageFile!
                              : Container(
                                  color: Colors.black,
                                ),
                        ),
                        Positioned(
                          bottom: 6,
                          right: 6,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                _getImage(ImageSource.camera);
                              },
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    profileName,
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Member since $creationDate',
                    style: const TextStyle(
                      color: Color.fromRGBO(188, 188, 188, 1),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
          Positioned(
            top: 48,
            right: 10,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.mode_edit_outlined, color: Colors.white),
                onPressed: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditProfilePage(),
                    ),
                  )
                },
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(7.0),
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/rewards_profile.png',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text(
                      'Rewards & Promotions',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_sharp),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/favourites_profile.png',
                      width: 24,
                      height: 24,
                    ),
                    title: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Favourites',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                            width:
                                12), // Add some horizontal space between the title and subtitle
                        Text(
                          '• 5 items',
                          style: TextStyle(
                            color: Color.fromRGBO(111, 111, 111, 1),
                            fontFamily: 'Poppins',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_sharp),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/following_profile.png',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text(
                      'Following',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_sharp),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/blog_profile.png',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text(
                      'Blog',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_sharp),
                    onTap: () {},
                  ),
                  const SizedBox(height: 35),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/wardrobe_profile.png',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text(
                      'Wardrobe',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_sharp),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/help_profile.png',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text(
                      'Help & Support',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_sharp),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/logout_profile.png',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text(
                      'Log out',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color.fromRGBO(235, 13, 13, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      clearAppStorage();
                      removeAllTokens(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailPage(), 
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
