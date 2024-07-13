import 'package:flutter/material.dart';

// class ApplyModal extends StatefulWidget {
//   const ApplyModal({super.key});

//   @override
//   State<ApplyModal> createState() => _ApplyModalState();
// }

// class _ApplyModalState extends State<ApplyModal> {
//   final BuildContext context;
//   final Function applyFunction;
//   final List<String> roles;
//   ApplyModal({
//     super.key,
//     required this.context,
//     required this.applyFunction,
//     required this.roles,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class ApplyModal extends StatelessWidget {
  final BuildContext context;
  final Function applyFunction;
  final List<String> roles;
  const ApplyModal({
    super.key,
    required this.context,
    required this.applyFunction,
    required this.roles,
  });

  buildApplyModal() {
    TextEditingController _descriptionController = TextEditingController();
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Application"),
        content: SizedBox(
          width: 50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Desired Role",
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              TextField(
                maxLines: 5,
                decoration: const InputDecoration.collapsed(
                    hintText: "Tell us about yourself..."),
                controller: _descriptionController,
                readOnly: false,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              applyFunction;
            },
            child: const Text("Apply"),
          ),
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
