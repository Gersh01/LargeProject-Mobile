import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProjectTile extends StatefulWidget {

  String title;
  String description;

  // final List<String> technologies;
  
  ProjectTile({
    super.key,
    required this.title,
    required this.description,
    // required this.technologies,
  });

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {

  final titleLength = 20;
  final descriptionLength = 200;

  @override
  Widget build(BuildContext context) {

    widget.title = widget.title.length > titleLength ? "${widget.title.substring(0, titleLength)}..." : widget.title;
    widget.description = widget.description.length > descriptionLength ? "${widget.description.substring(0, descriptionLength)}..." : widget.description;
    
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.orange[400],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.white,
            ),

            child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              color: Colors.orange[400],
            ),
            child: Column(
            
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
            
                    Expanded(
                      flex: 2,
                      child: Text(
                        widget.title,
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          "X Positions Left",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ),
            
                  ]
                ),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      "7 People",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),

                    Text(
                      "13 days left to join",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                )
            
            
              ]
            ),
          ),
          ),
          
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
              color: Colors.white,
            ),
            child: Column(
              children: [

                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(height: 10),
                Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                // const SizedBox(height: 10),
                // Wrap(
                //   spacing: 5,
                //   children: [
                //     Chip(
                //       label: const Text("Technology"),
                //       backgroundColor: Colors.primaries[0],
                //     ),
                //     Chip(
                //       label: const Text("Technology"),
                //       backgroundColor: Colors.primaries[1],
                //     ),
                //     Chip(
                //       label: const Text("Technology"),
                //       backgroundColor: Colors.primaries[2],
                //     ),
                //     Chip(
                //       label: const Text("Technology"),
                //       backgroundColor: Colors.primaries[3],
                //     ),
                //   ],
                // ),
              ],
            )
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.orange[400],
            ),
            child: Column(
              children: [
                const Text(
                  "Technologies",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 5,
                  children: [
                    Chip(
                      label: const Text("Technology"),
                      backgroundColor: Colors.primaries[0],
                    ),
                    Chip(
                      label: const Text("Technology"),
                      backgroundColor: Colors.primaries[1],
                    ),
                    Chip(
                      label: const Text("Technology"),
                      backgroundColor: Colors.primaries[2],
                    ),
                    Chip(
                      label: const Text("Technology"),
                      backgroundColor: Colors.primaries[3],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // const SizedBox(height: 10),
          // Wrap(
          //   spacing: 5,
          //   children: technologies
          //       .map((tech) => Chip(
          //             label: Text(tech),
          //             backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          //           ))
          //       .toList(),
          // ),
        ],
      ),
    );
  }
}