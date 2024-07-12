import 'package:flutter/material.dart';
import '../components/profile_pictures.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  final backGroundColor = const Color(0xfff3f4f6);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String image =
      "https://res.cloudinary.com/dlj2rlloi/image/upload/v1720043202/ef7zmzl5hokpnb3zd6en.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'League Spartan',
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(0, 4.0),
                  blurRadius: 20.0,
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                ),
              ]),
        ),
        backgroundColor: const Color(0xffe5e7eb),
      ),
      body: ListView(
        children: [
          Container(
              child: ProfilePictures(
            imageUrl: image,
          )

              // Text("Username"),
              ),
          Container(),
          Container(),
          Container()
        ],
      ),
    );
  }
}

        //   child: Column()
        // Text(
        //   'Profile',
        //   style: TextStyle(
        //     fontSize: 32,
        //     fontWeight: FontWeight.bold,
        //     fontFamily: 'League Spartan',
        //     color: Color.fromRGBO(124, 58, 237, 1),
        //     shadows: [ Shadow(
        //       offset: Offset(0, 4.0),
        //       blurRadius: 20.0,
        //       color: Color.fromRGBO(0, 0, 0, 0.4),
        //     ),]
        //   ),
        // ),