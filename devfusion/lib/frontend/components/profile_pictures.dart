import 'package:flutter/material.dart';

class ProfilePictures extends StatelessWidget {
  final String imageUrl;

  const ProfilePictures({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 45,
          backgroundImage: NetworkImage(
            imageUrl,
          )),
    );
  }
}
