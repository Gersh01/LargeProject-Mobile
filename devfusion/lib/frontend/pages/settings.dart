import 'dart:convert';
import 'dart:io';

import 'package:devfusion/frontend/components/input_field.dart';
import 'package:devfusion/frontend/components/SizedButton.dart';
// import 'package:devfusion/frontend/components/modals/apply_modal.dart';
// import 'package:devfusion/frontend/components/modals/confirm_cancel_modal.dart';
import 'package:devfusion/frontend/components/profile_pictures.dart';
import 'package:devfusion/frontend/components/shared_pref.dart';
import 'package:devfusion/frontend/pages/lander.dart';
import 'package:devfusion/frontend/pages/reset_password.dart';
import 'package:devfusion/frontend/utils/utility.dart';
import 'package:devfusion/themes/theme.dart';
import 'package:devfusion/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      "https://res.cloudinary.com/dlj2rlloi/image/upload/v1720043202/ef7zmzl5hokpnb3zd6en.png";

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
      print("settings jwt sucessful");
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
      print("settings jwt unsucessful");
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
      print("settings update name sucessful");
      var jsonResponse = jsonDecode(response.body);
      sharedPref.writeToken(jwtToken: jsonResponse['newToken']);
      getUserCredentials();
    } else {
      print(
          "settings update name unsucessful. Status code: ${response.statusCode}");
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
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'League Spartan',
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                child: ProfilePictures(imageUrl: profilePicUrl),
              ),
              Expanded(child: Container()),
              SizedButton(
                height: 25,
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'League Spartan',
                  color: Colors.white,
                ),
                // width: 120,
                placeholderText: 'Upload',
                backgroundColor: Theme.of(context).focusColor,
                textColor: Colors.white,
                onPressed: () async {
                  if (nameFormKey.currentState!.validate()) {
                    _pickImage;
                  }
                },
              ),
            ],
          ),
          const Divider(
            height: 10,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'League Spartan',
                    color: Colors.white,
                  ),
                ),
              ),
              Form(
                key: nameFormKey,
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: InputField(
                        backgroundColor: Theme.of(context).primaryColorDark,
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
                        backgroundColor: Theme.of(context).primaryColorDark,
                        placeholderText: 'Last Name',
                        controller: _lastNameController,
                        validator: validateLastName,
                        errorTextList: lastNameErrorList,
                        errorCount: lastNameErrorDouble,
                        hintText: lastName,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedButton(
                      height: 25,
                      textStyle: const TextStyle(
                        fontSize: 12,
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
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            height: 10,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
                  'Display Mode',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'League Spartan',
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Switch.adaptive(
                  activeTrackColor: darkAccent,
                  inactiveTrackColor: lightAccent,
                  thumbColor: (dark)
                      ? const MaterialStatePropertyAll<Color>(
                          darkPrimaryVariant)
                      : const MaterialStatePropertyAll<Color>(
                          lightPrimaryVariant),
                  value: dark,
                  onChanged: (bool value) {
                    setState(() {
                      dark = value;
                      // if (Provider.of<ThemeProvider>(context).themeData ==
                      //     null) {
                      //   if (dark) {
                      //     Provider.of<ThemeProvider>(context)
                      //         .setToggleTheme(darkMode);
                      //   } else {
                      //     Provider.of<ThemeProvider>(context)
                      //         .setToggleTheme(lightMode);
                      //   }
                      // } else {
                      //   Provider.of<ThemeProvider>(context, listen: false)
                      //       .toggleTheme();
                      // }
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(dark);
                    });
                    sharedPref.writeDarkMode(isDarkMode: dark);
                  },
                ),
              ),
            ],
          ),
          const Divider(
            height: 10,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'League Spartan',
                    color: Colors.white,
                  ),
                ),
              ),
              SizedButton(
                // width: 130,
                height: 25,
                textStyle: const TextStyle(
                  fontSize: 12,
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
          Expanded(child: Container()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Button(
                    placeholderText: 'About Us',
                    // backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
                    backgroundColor: neutral,
                    textColor: Colors.white,
                    onPressed: () {
                      // final confirmCancelModal = ConfirmCancelModal(
                      //   context: context,
                      //   firstTextButton: TextButton(
                      //     onPressed: () {
                      //       Navigator.of(context).pop();
                      //     },
                      //     child: const Text("Cancel"),
                      //   ),
                      //   secondTextButton: TextButton(
                      //     onPressed: () {
                      //       Navigator.of(context).pop();
                      //     },
                      //     child: const Text(
                      //       "Confirm",
                      //     ),
                      //   ),
                      //   title: const Text(
                      //     "Title",
                      //     textAlign: TextAlign.center,
                      //   ),
                      //   content: const Text(
                      //     "Content",
                      //     textAlign: TextAlign.center,
                      //   ),
                      // );
                      // confirmCancelModal.buildConfirmCancelModal();
//
//
                      // final applyModal = ApplyModal(
                      //   context: context,
                      //   applyFunction: () {},
                      //   roles: ["API", "Frontend"],
                      // );
                      // applyModal.buildApplyModal();
//
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const AboutUs()),
                      // );
                    },
                  ),
                  Button(
                    placeholderText: 'Logout',
                    // backgroundColor: const Color.fromRGBO(124, 58, 237, 1),
                    backgroundColor: danger,
                    textColor: Colors.white,
                    onPressed: () {
                      sharedPref.removeToken();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Lander()),
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
