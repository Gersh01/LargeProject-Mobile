import 'package:devfusion/frontend/json/communication.dart';
import 'package:flutter/material.dart';
import '../../utils/utility.dart';

class CommunicationBubble extends StatefulWidget {
  final Communication communication;
  final bool hideLink;

  const CommunicationBubble({
    super.key,
    required this.communication,
    required this.hideLink,
  });

  @override
  State<CommunicationBubble> createState() => _CommunicationBubble();
}

class _CommunicationBubble extends State<CommunicationBubble> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: getBubbleColor(widget.communication.name),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          widget.communication.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            color: Theme.of(context).primaryColorDark,
          ),
          padding: const EdgeInsets.all(5),
          child: widget.hideLink
              ? const Text("Hidden")
              : Text(widget.communication.link.isEmpty
                  ? "None"
                  : widget.communication.link),
        )
      ]),
    );
  }
}
