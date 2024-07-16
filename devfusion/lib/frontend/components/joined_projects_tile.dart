import 'package:flutter/material.dart';

import '../json/Project.dart';
import '../json/Role.dart';
import '../json/team_member.dart';
import 'tech_bubble.dart';

//ignore: must_be_immutable
class JoinedProjectsTile extends StatefulWidget {
  final Project project;
  final String username;

  const JoinedProjectsTile(
      {super.key, required this.project, required this.username});

  @override
  State<JoinedProjectsTile> createState() => _JoinedProjectsTileState();
}

class _JoinedProjectsTileState extends State<JoinedProjectsTile> {
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
        daysText = "$days days Until Start";
      } else {
        daysText = "$days day Until Start";
      }
    } else {
      int days = widget.project.deadline.difference(DateTime.now()).inDays;

      if (days > 1) {
        daysText = "$days days until project begins";
      } else {
        daysText = "$days day until project begins";
      }
    }

    // String yourRole = widget.project.teamMembers.firstWhere((element) => element
    String yourRole = widget.project.teamMembers
        .firstWhere((element) => element.username == widget.username)
        .role;

    title = title.length > titleLength
        ? "${title.substring(0, titleLength)}..."
        : title;
    description = description.length > descriptionLength
        ? "${description.substring(0, descriptionLength)}..."
        : description;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Theme.of(context).primaryColor,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                color: Theme.of(context).focusColor,
              ),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Role",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  TechBubble(technology: yourRole, editMode: false),

                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.black,
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
