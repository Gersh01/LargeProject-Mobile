import 'package:devfusion/frontend/components/Divider.dart';
import 'package:devfusion/frontend/components/bubbles/user_bubble.dart';
import 'package:flutter/material.dart';
import '../../components/manage_team/members_per_role.dart';
import '../../utils/utility.dart';
import '../../components/Divider.dart';

class RoleBubbles extends StatefulWidget {
  final MembersPerRole roleInfo;

  const RoleBubbles({
    super.key,
    required this.roleInfo,
  });

  @override
  State<RoleBubbles> createState() => _RoleBubbles();
}

class _RoleBubbles extends State<RoleBubbles> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        constraints: BoxConstraints(minHeight: 170.0),
        decoration: (BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: BorderRadius.circular(10))),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: getBubbleColor(widget.roleInfo.role),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "${widget.roleInfo.role}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              "(${widget.roleInfo.members!.length}/${widget.roleInfo.count})",
                              style:
                                  TextStyle(color: Theme.of(context).hintColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${widget.roleInfo.description}",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 14,
                        fontFamily: "poppins"),
                  ),
                )),
            const Padding(
              padding: EdgeInsets.all(10),
              child: DividerLine(),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Text(
                        "Current Members",
                        style: TextStyle(
                            fontSize: 16, color: Theme.of(context).hintColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: widget.roleInfo.members!.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "None",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).hintColor),
                            )),
                      )
                    : Container(
                        alignment: Alignment.topLeft,
                        child: Wrap(
                          children: widget.roleInfo.members!.map((member) {
                            return UserBubble(
                                userId: member.userId,
                                username: member.username);
                          }).toList(),
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
