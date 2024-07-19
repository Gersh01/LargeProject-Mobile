import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:devfusion/frontend/components/Divider.dart';
import 'package:devfusion/frontend/components/input_field.dart';
import 'package:devfusion/frontend/components/SizedButton.dart';
// import 'package:devfusion/frontend/components/modals/apply_modal.dart';
// import 'package:devfusion/frontend/components/modals/confirm_cancel_modal.dart';
import 'package:devfusion/frontend/components/profile_pictures.dart';
import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/pages/reset_password.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:devfusion/themes/theme.dart';
import 'package:devfusion/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../components/Button.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final nameFormKey = GlobalKey<FormState>();

  SharedPref sharedPref = SharedPref();

  File? _imageFile;

  bool dark = false;

  String profilePicUrl =
      "https://res.cloudinary.com/dlj2rlloi/image/upload/v1721333449/profileImage_hqdvzt.webp";

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  String firstName = "";
  String lastName = "";

  List<String>? firstNameErrorList;
  double firstNameErrorDouble = 0;
  List<String>? lastNameErrorList;
  double lastNameErrorDouble = 0;

  Future<void> _pickImage() async {
    PermissionStatus storagePermissionStatus = await Permission.storage.status;
    print(storagePermissionStatus.toString());
    print("1");
    ImagePicker picker = ImagePicker();
    print("2");
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print("3");
    setState(() {
      if (pickedFile != null) _imageFile = File(pickedFile.path);
    });
    print("4");
  }

  void uploadProfilePicture() async {
    var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
      ..fields['upload_preset'] = ''
      ..files.add(await http.MultipartFile.fromPath('file', _imageFile!.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      setState(() {
        profilePicUrl = jsonMap['url'];
      });
    }
  }

  void getUserCredentials() async {
    String? token = await sharedPref.readToken();
    var reqBody = {"token": token};

    var response = await http.post(
      Uri.parse(jwtUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      log("settings jwt sucessful");
      var jsonResponse = jsonDecode(response.body);
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);
      setState(() {
        firstName = jsonResponse['firstName'];
        lastName = jsonResponse['lastName'];
        _firstNameController.text = jsonResponse['firstName'];
        _lastNameController.text = jsonResponse['lastName'];
        profilePicUrl = jsonResponse['link'];
      });
    } else {
      log("settings jwt unsucessful");
    }
  }

  void updateName() async {
    String? token = await sharedPref.readToken();
    var reqBody = {
      "token": token,
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text
    };

    var response = await http.put(
      Uri.parse(updateUserUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      log("settings update name sucessful");
      var jsonResponse = jsonDecode(response.body);
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);
      getUserCredentials();
    } else {
      log("settings update name unsucessful. Status code: ${response.statusCode}");
    }
  }

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        firstNameErrorList = ['First Name is required'];
        firstNameErrorDouble = 1;
      });
      return 'First Name is required';
    } else if (value.length > 18) {
      setState(() {
        firstNameErrorList = ['First Name is too long'];
        firstNameErrorDouble = 1;
      });
      return 'First Name is too long';
    } else {
      setState(() {
        firstNameErrorList = null;
        firstNameErrorDouble = 0;
      });
      return null;
    }
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        lastNameErrorList = ['Last Name is required'];
        lastNameErrorDouble = 1;
      });
      return 'Last Name is required';
    } else if (value.length > 18) {
      setState(() {
        lastNameErrorList = ['Last Name is too long'];
        lastNameErrorDouble = 1;
      });
      return 'Last Name is too long';
    } else {
      setState(() {
        lastNameErrorList = null;
        lastNameErrorDouble = 0;
      });
      return null;
    }
  }

  getDarkModeInfo() async {
    bool? darkModeInfo = await sharedPref.readDarkMode();
    darkModeInfo ??= true;
    dark = darkModeInfo;
  }

  @override
  void initState() {
    // getDarkModeInfo();
    getUserCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool systemInDark = brightness == Brightness.dark;
    if (Provider.of<ThemeProvider>(context).themeData == null) {
      dark = systemInDark;
    } else {
      dark = (Provider.of<ThemeProvider>(context).themeData == darkMode)
          ? true
          : false;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'League Spartan',
            color: Theme.of(context).hintColor,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: OverflowBox(
        alignment: Alignment.topCenter,
        minHeight: 0,
        maxHeight: double.infinity,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ProfilePictures(imageUrl: profilePicUrl),
                      Expanded(child: Container()),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const DividerLine(),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'League Spartan',
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      Form(
                        key: nameFormKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InputField(
                                color: Theme.of(context).hintColor,
                                backgroundColor:
                                    Theme.of(context).primaryColorDark,
                                placeholderText: 'First Name',
                                controller: _firstNameController,
                                validator: validateFirstName,
                                errorTextList: firstNameErrorList,
                                errorCount: firstNameErrorDouble,
                                hintText: firstName,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: InputField(
                                color: Theme.of(context).hintColor,
                                backgroundColor:
                                    Theme.of(context).primaryColorDark,
                                placeholderText: 'Last Name',
                                controller: _lastNameController,
                                validator: validateLastName,
                                errorTextList: lastNameErrorList,
                                errorCount: lastNameErrorDouble,
                                hintText: lastName,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedButton(
                            height: 30,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'League Spartan',
                              color: Colors.white,
                            ),
                            // width: 120,
                            placeholderText: 'Save',
                            backgroundColor: Theme.of(context).focusColor,
                            textColor: Colors.white,
                            onPressed: () async {
                              if (nameFormKey.currentState!.validate()) {
                                updateName();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const DividerLine(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Display Mode',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'League Spartan',
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      Switch.adaptive(
                        activeTrackColor: darkAccent,
                        inactiveTrackColor: lightAccent,
                        thumbColor: (dark)
                            ? const WidgetStatePropertyAll<Color>(
                                darkPrimaryVariant)
                            : const WidgetStatePropertyAll<Color>(
                                lightPrimaryVariant),
                        value: dark,
                        onChanged: (bool value) {
                          setState(() {
                            dark = value;
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toggleTheme(dark);
                          });
                          sharedPref.writeDarkMode(isDarkMode: dark);
                        },
                      ),
                    ],
                  ),
                  const DividerLine(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'League Spartan',
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      SizedButton(
                        // width: 130,
                        height: 30,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'League Spartan',
                          color: Colors.white,
                        ),
                        placeholderText: 'Reset Password',
                        backgroundColor: danger,
                        textColor: Colors.white,
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetPassword(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  Button(
                    placeholderText: 'About Us',
                    backgroundColor: neutral,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, '/aboutUs');
                    },
                  ),
                  Button(
                    placeholderText: 'Logout',
                    backgroundColor: danger,
                    textColor: Colors.white,
                    onPressed: () {
                      sharedPref.removeToken();
                      Navigator.pushNamed(context, '/login');
                    },
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
