import 'package:devfusion/frontend/pages/profile_page.dart';
import 'package:flutter/material.dart';

class UserBubble extends StatefulWidget {
  final String? userId;
  final String? username;

  const UserBubble({
    super.key,
    this.userId,
    this.username,
  });

  @override
  State<UserBubble> createState() => _UserBubble();
}

class _UserBubble extends State<UserBubble> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(userId: widget.userId)));
        },
        child: Text(
          "@${widget.username}",
          style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).hintColor,
              fontStyle: FontStyle.italic),
        ));
  }
}
