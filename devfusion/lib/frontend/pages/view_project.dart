import 'package:flutter/material.dart';

import '../components/Divider.dart';
import '../json/Project.dart';
import '../json/Role.dart';

class ViewProject extends StatefulWidget {
  final Project project;

  const ViewProject({super.key, required this.project});

  @override
  State<ViewProject> createState() => _ViewProjectState();
}

class _ViewProjectState extends State<ViewProject> {
  @override
  Widget build(BuildContext context) {
    print(widget.project.title);

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

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.project.title),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Text(
                currentCount.toString(),
                textAlign: TextAlign.left,
              ),
              Icon(Icons.person)
            ]),
            Row(
              children: [
                Icon(Icons.access_time_filled),
                Text(
                  daysText,
                  textAlign: TextAlign.left,
                ),
              ],
            )
          ]),
          Divider(),
          Text(
            "Description",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          )),
          Text(widget.project.description),

          Text(
            "Position Requirements",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
          
        ]),
      ),
    );
  }
}