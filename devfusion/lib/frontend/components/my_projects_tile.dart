import 'package:flutter/material.dart';

import '../json/Project.dart';

//ignore: must_be_immutable
class MyProjectsTile extends StatefulWidget {
  final Project project;

  const MyProjectsTile({super.key, required this.project});

  @override
  State<MyProjectsTile> createState() => _MyProjectsTileState();
}

class _MyProjectsTileState extends State<MyProjectsTile> {
  final titleLength = 30;
  final descriptionLength = 120;

  @override
  Widget build(BuildContext context) {
    String title = widget.project.title;
    String description = widget.project.description;

    int currentCount = widget.project.teamMembers.length;

    String daysText = "";

    if (widget.project.projectStartDate.isAfter(DateTime.now())) {
      int days =
          widget.project.projectStartDate.difference(DateTime.now()).inDays;

      if (days > 1) {
        daysText = "$days days until Start";
      } else {
        daysText = "$days day until Start";
      }
    } else {
      int days = widget.project.deadline.difference(DateTime.now()).inDays;

      if (days > 1) {
        daysText = "$days days until project begins";
      } else {
        daysText = "$days day until project begins";
      }
    }

    title = title.length > titleLength
        ? "${title.substring(0, titleLength)}..."
        : title;
    description = description.length > descriptionLength
        ? "${description.substring(0, descriptionLength)}..."
        : description;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).focusColor,
            Theme.of(context).highlightColor
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //No idea where this is located
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Theme.of(context).primaryColorDark,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).focusColor,
                      Theme.of(context).highlightColor
                    ],
                  )),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          currentCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Text(
                      daysText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                )
              ]),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: Theme.of(context).primaryColorDark,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
