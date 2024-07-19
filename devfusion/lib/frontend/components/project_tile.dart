import 'package:devfusion/frontend/components/Divider.dart';
import 'package:flutter/material.dart';

import '../json/Project.dart';
import '../json/Role.dart';
import '../json/team_member.dart';
import 'bubbles/tech_bubble.dart';
import 'package:devfusion/frontend/components/shared_pref.dart';

//ignore: must_be_immutable
class ProjectTile extends StatefulWidget {
  final Project project;

  const ProjectTile({super.key, required this.project});

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  final titleLength = 17;
  final descriptionLength = 120;
  SharedPref sharedPref = SharedPref();
  bool darkMode = false;
  int positionLeft = 0;

  @override
  Widget build(BuildContext context) {
    String title = widget.project.title;
    String description = widget.project.description;
    List<String> technologies = widget.project.technologies;

    int currentCount = widget.project.teamMembers.length;
    int numDaysTilStart =
        widget.project.projectStartDate.difference(DateTime.now()).inDays;

    int positionLeft = 0;

    for (Role role in widget.project.roles) {
      int totalCount = role.count;

      for (TeamMember member in widget.project.teamMembers) {
        if (member.role == role.role) {
          totalCount--;
        }
      }

      if (totalCount > 0) {
        positionLeft += totalCount;
      }
    }

    String numDaysTilStartText = numDaysTilStart > 1
        ? "$numDaysTilStart days left to join"
        : "$numDaysTilStart day left to join";

    String positionLeftText = positionLeft > 1
        ? "$positionLeft Positions Left"
        : "$positionLeft Position Left";

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
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          positionLeftText,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
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
                      numDaysTilStartText,
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
                crossAxisAlignment: CrossAxisAlignment.start,
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

                  const DividerLine(),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Technologies",
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          spacing: 10,
                          children: technologies
                              .map((tech) => TechBubble(
                                    technology: tech,
                                    editMode: false,
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
