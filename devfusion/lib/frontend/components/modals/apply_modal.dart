import 'package:devfusion/frontend/components/Button.dart';
import 'package:devfusion/frontend/components/SizedButton.dart';
import 'package:devfusion/frontend/components/modals/apply_dropdown_menu.dart';
import 'package:devfusion/themes/theme.dart';
import 'package:flutter/material.dart';

// class ApplyModal extends StatefulWidget {
//   final List<String> roles;

//   const ApplyModal({super.key, required this.roles});

//   @override
//   State<ApplyModal> createState() => _ApplyModalState();
// }

// class _ApplyModalState extends State<ApplyModal> {
//   buildApplyModal() {
//     TextEditingController _descriptionController = TextEditingController();
//     List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
//     String? selectedItem;
//     return showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Application"),
//         content: SizedBox(
//           width: 50,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Desired Role",
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(top: 10),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(top: 10),
//               ),
//               TextField(
//                 maxLines: 5,
//                 decoration: const InputDecoration.collapsed(
//                     hintText: "Tell us about yourself..."),
//                 controller: _descriptionController,
//                 readOnly: false,
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () {},
//             child: const Text("Apply"),
//           ),
//         ],
//         actionsAlignment: MainAxisAlignment.spaceBetween,
//         elevation: 20,
//         backgroundColor: Colors.blue,
//       ),
//       barrierDismissible: false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return buildApplyModal();
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
              ApplyDropDown(roles: roles),
              const Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).primaryColorDark,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Description"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextField(
                        maxLines: 5,
                        decoration: const InputDecoration.collapsed(
                            hintText: "Tell us about yourself..."),
                        controller: _descriptionController,
                        readOnly: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Button(
            // height: 25,
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'League Spartan',
              color: Colors.white,
            ),
            // width: 120,
            placeholderText: 'Apply',
            backgroundColor: approve,
            textColor: Colors.white,
            onPressed: () {
              applyFunction;
            },
          ),
          Button(
            // height: 25,
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'League Spartan',
              color: Colors.white,
            ),
            // width: 120,
            placeholderText: 'Cancel',
            backgroundColor: danger,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        // actionsAlignment: MainAxisAlignment.spaceBetween,
        elevation: 20,
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
