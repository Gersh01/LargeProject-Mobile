import 'package:flutter/material.dart';
import '../components/profile_pictures.dart';
import '../components/SizedButton.dart';

class AboutUs extends StatelessWidget{

  const AboutUs({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).hintColor
          ),
          onPressed: () => Navigator.of(context).pop,
        ),
        title: Text(
          'About Us',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize:40)
        ),
        backgroundColor: Theme.of(context).primaryColor,

      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),


        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [

              //PM Block
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 20.0, right:11.0, left: 11.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Project Manager',
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Row(
                            children: [
                              const Center(
                                child: ProfilePictures(
                                  imageUrl: 'http://www.dev-fusion.com/assets/Alex-HWcV7KuD.png'
                                )
                              ),

                              const Expanded(
                                child: SizedBox()
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,

                                children: [
                                  Text(
                                    'Alex Gershfeld',
                                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18),
                                  ),

                                  SizedButton(
                                    height: 24,
                                    backgroundColor: Theme.of(context).focusColor,
                                    placeholderText: 'Github',
                                    textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20, color: Colors.white),
                                    ),
                                ],
                              )
                            ]
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ),

              //Frontend Block
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 20.0, right:11.0, left: 11.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Frontend',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(
                                children: [
                                  const Center(
                                      child: ProfilePictures(
                                          imageUrl: 'http://www.dev-fusion.com/assets/Xutao-7cFVYx9G.jpg'
                                      )
                                  ),

                                  const Expanded(
                                      child: SizedBox()
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,

                                    children: [
                                      Text(
                                        'Xutao Gao',
                                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18),
                                      ),

                                      SizedButton(
                                          height: 24,
                                          backgroundColor: Theme.of(context).focusColor,
                                          placeholderText: 'Github',
                                          textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20, color: Colors.white))
                                    ],
                                  )
                                ]
                            ),
                          ),

                          Divider(),

                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(
                                children: [
                                  const Center(
                                      child: ProfilePictures(
                                          imageUrl: 'http://www.dev-fusion.com/assets/James-CDpxTaa0.png'
                                      )
                                  ),

                                  const Expanded(
                                      child: SizedBox()
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,

                                    children: [
                                      Text(
                                        'James Salzer',
                                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18),
                                      ),

                                      SizedButton(
                                          height: 24,
                                          backgroundColor: Theme.of(context).focusColor,
                                          placeholderText: 'Github',
                                          textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20, color: Colors.white))
                                    ],
                                  )
                                ]
                            ),
                          ),

                          Divider(),

                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(
                                children: [
                                  const Center(
                                      child: ProfilePictures(
                                          imageUrl: 'http://www.dev-fusion.com/assets/Jacob-BRa2cTzU.png'
                                      )
                                  ),

                                  const Expanded(
                                      child: SizedBox()
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,

                                    children: [
                                      Text(
                                        'Jacob Peach',
                                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18),
                                      ),

                                      SizedButton(
                                          height: 24,
                                          backgroundColor: Theme.of(context).focusColor,
                                          placeholderText: 'Github',
                                          textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20, color: Colors.white))
                                    ],
                                  )
                                ]
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ),

              //API Block
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 20.0, right:11.0, left: 11.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'API',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20),
                            ),
                          ),

                          //Golden
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(
                                children: [
                                  const Center(
                                      child: ProfilePictures(
                                          imageUrl: 'http://www.dev-fusion.com/assets/Golden-RBJipkJ7.png'
                                      )
                                  ),

                                  const Expanded(
                                      child: SizedBox()
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,

                                    children: [
                                      Text(
                                        'Golden Lin',
                                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18),
                                      ),

                                      SizedButton(
                                          height: 24,
                                          backgroundColor: Theme.of(context).focusColor,
                                          placeholderText: 'Github',
                                          textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20, color: Colors.white))
                                    ],
                                  )
                                ]
                            ),
                          ),

                          Divider(),

                          //Alperen
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(
                                children: [
                                  const Center(
                                      child: ProfilePictures(
                                          imageUrl: 'http://www.dev-fusion.com/assets/Alperen-Csagl1zO.png'
                                      )
                                  ),

                                  const Expanded(
                                      child: SizedBox()
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,

                                    children: [
                                      Text(
                                        'Alperen Yazmaci',
                                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18),
                                      ),

                                      SizedButton(
                                    
                                        height: 24,
                                        backgroundColor: Theme.of(context).focusColor,
                                        placeholderText: 'Github',
                                        textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20, color: Colors.white)),
                                    ],
                                  )
                                ]
                            ),
                          ),

                        ],
                      ),
                    )
                ),
              ),

              //Backend Block
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 20.0, right:11.0, left: 11.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Backend',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(
                                children: [
                                  const Center(
                                      child: ProfilePictures(
                                          imageUrl: 'http://www.dev-fusion.com/assets/Tony-CqV0TySZ.png'
                                      )
                                  ),

                                  const Expanded(
                                      child: SizedBox()
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,

                                    children: [
                                      Text(
                                        'Tony Chau',
                                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18),
                                      ),

                                      SizedButton(
                                          height: 24,
                                          backgroundColor: Theme.of(context).focusColor,
                                          placeholderText: 'Github',
                                          textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20, color: Colors.white))
                                    ],
                                  )
                                ]
                            ),
                          )
                        ],
                      ),
                    )
                ),
              )
            ]
                ),
        )
      )
    );
  }
}