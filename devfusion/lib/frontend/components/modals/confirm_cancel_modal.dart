import 'package:flutter/material.dart';

class ConfirmCancelModal extends StatelessWidget {
  final BuildContext context;
  final TextButton firstTextButton;
  final TextButton secondTextButton;
  final Widget title;
  final Widget content;
  const ConfirmCancelModal(
      {super.key,
      required this.context,
      required this.firstTextButton,
      required this.secondTextButton,
      required this.title,
      required this.content});

  buildConfirmCancelModal() {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: title,
        content: content,
        actions: [
          firstTextButton,
          secondTextButton,
        ],
        elevation: 20,
        backgroundColor: Colors.black87,
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Title"),
      content: const Text("content"),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text("Confirm"),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Cancel"),
        ),
      ],
      elevation: 20,
      backgroundColor: Colors.lightBlue,
    );
  }
}
