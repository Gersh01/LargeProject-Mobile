import 'package:devfusion/frontend/components/Button.dart';
import 'package:devfusion/frontend/components/SizedButton.dart';
import 'package:devfusion/themes/theme.dart';
import 'package:flutter/material.dart';

class ConfirmCancelModal extends StatelessWidget {
  final BuildContext context;
  final Text? title;
  final Function? approveFunction;
  const ConfirmCancelModal({
    super.key,
    required this.context,
    this.title,
    this.approveFunction,
  });

  buildConfirmCancelModal() {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        // insetPadding: const EdgeInsets.only(left: 100, right: 100),
        title: (title != null)
            ? title
            : const Text(
                "Are You Sure?",
                textAlign: TextAlign.center,
              ),
        titleTextStyle: TextStyle(
            fontSize: 36,
            fontFamily: 'League Spartan',
            color: Theme.of(context).hintColor),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button(
              // height: 30,
              // width: 100,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'League Spartan',
                color: Colors.white,
              ),
              // width: 120,
              placeholderText: 'Confirm',
              backgroundColor: approve,
              textColor: Colors.white,
              onPressed: (approveFunction != null)
                  ? () {
                      approveFunction!();
                      Navigator.pop(context);
                    }
                  : () {
                      Navigator.pop(context);
                    },
            ),
            const SizedBox(
              height: 5,
            ),
            Button(
              // height: 30,
              // width: 100,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'League Spartan',
                color: Colors.white,
              ),
              // width: 120,
              placeholderText: 'Cancel',
              backgroundColor: danger,
              textColor: Colors.white,
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     SizedButton(
        //       height: 30,
        //       width: 100,
        //       textStyle: const TextStyle(
        //         fontSize: 20,
        //         fontWeight: FontWeight.bold,
        //         fontFamily: 'League Spartan',
        //         color: Colors.white,
        //       ),
        //       // width: 120,
        //       placeholderText: 'Cancel',
        //       backgroundColor: danger,
        //       textColor: Colors.white,
        //       onPressed: () async {
        //         Navigator.pop(context);
        //       },
        //     ),
        //     SizedButton(
        //       height: 30,
        //       width: 100,
        //       textStyle: const TextStyle(
        //         fontSize: 20,
        //         fontWeight: FontWeight.bold,
        //         fontFamily: 'League Spartan',
        //         color: Colors.white,
        //       ),
        //       // width: 120,
        //       placeholderText: 'Approve',
        //       backgroundColor: approve,
        //       textColor: Colors.white,
        //       onPressed: () async {
        //         (approveFunction != null)
        //             ? approveFunction
        //             : Navigator.pop(context);
        //       },
        //     ),
        //   ],
        // ),
        // actions: [
        //   Row(
        //     children: [
        //       SizedButton(
        //         height: 25,
        //         textStyle: const TextStyle(
        //           fontSize: 12,
        //           fontWeight: FontWeight.bold,
        //           fontFamily: 'League Spartan',
        //           color: Colors.white,
        //         ),
        //         // width: 120,
        //         placeholderText: 'Cancel',
        //         backgroundColor: danger,
        //         textColor: Colors.white,
        //         onPressed: () async {
        //           Navigator.pop(context);
        //         },
        //       ),
        //       SizedButton(
        //         height: 25,
        //         textStyle: const TextStyle(
        //           fontSize: 12,
        //           fontWeight: FontWeight.bold,
        //           fontFamily: 'League Spartan',
        //           color: Colors.white,
        //         ),
        //         // width: 120,
        //         placeholderText: 'Approve',
        //         backgroundColor: approve,
        //         textColor: Colors.white,
        //         onPressed: () async {
        //           (approveFunction != null)
        //               ? approveFunction
        //               : Navigator.pop(context);
        //         },
        //       ),
        //     ],
        //   ),
        // ],
        actionsAlignment: MainAxisAlignment.spaceBetween,
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
