import 'package:flutter/material.dart';
import '../components/Button.dart';

class Lander extends StatelessWidget {
  const Lander({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        home: Scaffold(
        backgroundColor: const Color.fromRGBO(124, 58, 237, 1),



        body: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 250.0, bottom: 5.0),
        
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 32,
                    ),
                    "THRIVE IN THE POWER OF OPEN-SOURCE TO DRIVE INNOVATION!"
                  )
                ),

                const SizedBox(height: 15),

                const Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                    "Whether you're a seasoned developer or just starting out, you'll find a place here"
                  )
                ),

                const SizedBox(height: 15),


                const Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                    "connect with like-minded individuals who share your passion for coding"
                  )
                ),

                const SizedBox(height: 50),


                const Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                    "Together, we can build a brighter future, one line of code at a time!"
                  )
                ),

                Expanded(
                  child: Container(
                    color: const Color.fromRGBO(124, 58, 237, 1),
                  )
                ),

                Button(placeholderText: "Get Started", backgroundColor: Colors.white, textColor: Colors.black, 
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  }
                )
                

              ],)
            )
          )
        );
  }
}