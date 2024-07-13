import 'package:devfusion/frontend/components/profile/bio_fields.dart';
import 'package:flutter/material.dart';
import '../components/profile_pictures.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String image =
      "https://res.cloudinary.com/dlj2rlloi/image/upload/v1720043202/ef7zmzl5hokpnb3zd6en.png";

  bool profile = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'League Spartan',
              color: Colors.white
              // color: Theme.of(context).white,
              ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: ProfilePictures(
                  imageUrl: image,
                ),
              ),
              const Text(
                "Username",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'League Spartan',
                  color: Colors.white,
                ),
              ),
            ]),
          ),
          Container(
              padding: const EdgeInsets.all(10.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BioFields(
                    myProfile: true,
                    bioMessage: "null",
                  )
                ],
              )),
          Container(),
          Container()
        ],
      ),
    );
  }
}
