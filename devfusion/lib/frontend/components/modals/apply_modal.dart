import 'package:devfusion/frontend/components/modals/apply_modal_alert_dialog.dart';
import 'package:flutter/material.dart';

class ApplyModal extends StatelessWidget {
  final BuildContext context;
  final String projectId;
  final List<String> givenRoles;
  const ApplyModal({
    super.key,
    required this.context,
    required this.projectId,
    required this.givenRoles,
  });

  buildApplyModal() {
    return showDialog(
      context: context,
      builder: (_) => ApplyModalAlertDialog(
        context: context,
        projectId: projectId,
        givenRoles: givenRoles,
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
