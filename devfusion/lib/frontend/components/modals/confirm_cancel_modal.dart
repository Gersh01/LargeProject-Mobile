import 'package:flutter/material.dart';

class ConfirmCancelModal extends StatelessWidget {
  final BuildContext context;
  final TextButton firstTextButton;
  final TextButton secondTextButton;
  final Text title;
  final Text content;
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
        actionsAlignment: MainAxisAlignment.spaceBetween,
        elevation: 20,
        backgroundColor: Colors.blue,
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
