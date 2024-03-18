import 'package:faszen/services/storage_service.dart';
import 'package:faszen/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class EditProfileInformation extends StatefulWidget {
  const EditProfileInformation({Key? key}) : super(key: key);

  @override
  _EditProfileInformationState createState() => _EditProfileInformationState();
}

class _EditProfileInformationState extends State<EditProfileInformation> {
  final StorageService storage = StorageService();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final dateOfBirthFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneNumberFocus = FocusNode();

  String firstName = '';
  String lastName = '';
  String dateOfBirth = '';
  String email = '';
  String phoneNumber = '';

  // List of country codes
  final List<String> countryCodes = ['+91', '+61', '+44', '+88', '+93']; // Add more country codes as needed
  String selectedCountryCode = '+91'; // Default selected country code

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final firstname = (await storage.getFirstname())!;
    final lastname = (await storage.getLastname())!;
    final email = (await storage.getEmail())!;

    setState(() {
      firstNameController.text = _capitalizeFirstLetter(firstname);
      lastNameController.text = _capitalizeFirstLetter(lastname);
      emailController.text = email;
    });
  }

  String _capitalizeFirstLetter(String input) {
    if (input.isEmpty) return '';
    return input[0].toUpperCase() + input.substring(1);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        final year = pickedDate.year;
        final month = pickedDate.month;
        final day = pickedDate.day;

        final formattedDate = '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';

        dateOfBirthController.text = formattedDate;
      });
    }
  }

  void updateInputValues() {
    setState(() {
      firstName = firstNameController.text;
      lastName = lastNameController.text;
      dateOfBirth = dateOfBirthController.text;
      email = emailController.text;
      phoneNumber = phoneNumberController.text;
    });
  }

  void validateInputValues() {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        dateOfBirth.isEmpty ||
        email.isEmpty ||
        phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackBar(
          context: context,
          message: 'Enter Incomplete Fields !!',
          type: SnackBarType.warning,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackBar(
          context: context,
          message: 'Information Updated SuccessFully',
          type: SnackBarType.success,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            icon: Icon(Icons.chevron_left_sharp, size: MediaQuery.of(context).size.height * 0.045),
            onPressed: () {
              Navigator.pop(context); // Navigate back when pressed
            },
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text(
            'PROFILE INFORMATION',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              validateInputValues();
            },
            child: const Text(
              'DONE',
              style: TextStyle(
                color: Color.fromRGBO(235, 13, 13, 1),
                fontFamily: 'Poppins',
                fontSize: 18,
              ),
            ),
          ),
        ],
        elevation: 5,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'FIRST NAME',
                          style: TextStyle(
                            color: Color.fromRGBO(111, 111, 111, 1),
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          controller: firstNameController,
                          focusNode: firstNameFocus,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (value) {
                            firstNameFocus.unfocus();
                            FocusScope.of(context).requestFocus(lastNameFocus);
                          },
                          onChanged: (value) {
                            updateInputValues();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LAST NAME',
                          style: TextStyle(
                            color: Color.fromRGBO(111, 111, 111, 1),
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          controller: lastNameController,
                          focusNode: lastNameFocus,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (value) {
                            lastNameFocus.unfocus();
                            FocusScope.of(context).requestFocus(dateOfBirthFocus);
                          },
                          onChanged: (value) {
                            updateInputValues();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              const Text(
                'DATE OF BIRTH',
                style: TextStyle(
                  color: Color.fromRGBO(111, 111, 111, 1),
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextField(
                controller: dateOfBirthController,
                focusNode: dateOfBirthFocus,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.datetime,
                onSubmitted: (value) {
                  dateOfBirthFocus.unfocus();
                  FocusScope.of(context).requestFocus(emailFocus);
                },
                onChanged: (value) {
                  updateInputValues();
                },
                decoration: InputDecoration(
                  hintText: 'DD/MM/YYYY',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month_outlined),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ), 
              ),
              const SizedBox(height: 30.0),
              const Text(
                'EMAIL',
                style: TextStyle(
                  color: Color.fromRGBO(111, 111, 111, 1),
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextField(
                controller: emailController,
                focusNode: emailFocus,
                enabled: false,
                textInputAction: TextInputAction.next,
                onSubmitted: (value) {
                  emailFocus.unfocus();
                  FocusScope.of(context).requestFocus(phoneNumberFocus);
                },
                onChanged: (value) {
                  updateInputValues();
                },
              ),
              const SizedBox(height: 30.0),
              const Text(
                'PHONE NUMBER',
                style: TextStyle(
                  color: Color.fromRGBO(111, 111, 111, 1),
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: DropdownButton<String>(
                      icon: const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Icon(Icons.arrow_drop_down, size: 30),
                      ),
                      alignment: AlignmentDirectional.topStart,
                      value: selectedCountryCode,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCountryCode = newValue!;
                        });
                      },
                      items: countryCodes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              width: 30, // Adjust the width as needed
                              child: Text(value),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextField(
                      controller: phoneNumberController,
                      focusNode: phoneNumberFocus,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                      onSubmitted: (value) {
                        phoneNumberFocus.unfocus();
                      },
                      onChanged: (value) {
                        updateInputValues();
                      },
                      decoration: const InputDecoration(
                        hintText: '123 456 789',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
