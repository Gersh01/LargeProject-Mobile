import 'package:flutter/material.dart';
import '../components/profile_pictures.dart';
import '../components/SizedButton.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/Button.dart';


class AboutUs extends StatelessWidget{

  
  _launchURLBrowser(String link) async {

    dynamic url;
    link == 'alex'? url = Uri.parse('https://github.com/Gersh01')
    : link == 'xutao'? url = Uri.parse('https://github.com/XutaoG')
    : link == 'james'? url = Uri.parse('https://github.com/jsalzer312')
    : link == 'jacob'? url = Uri.parse('https://github.com/GoldenLin9')
    : link == 'golden'? url = Uri.parse('https://github.com/JPEACH34')
    : link == 'Alperen'? url = Uri.parse('https://github.com/alperenyazmaci')
    : link == 'tony'? url = Uri.parse('https://github.com/tonych312312')
    : url = Uri.parse('https://github.com/Gersh01/LargeProject-Mobile');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }


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
          onPressed: () => Navigator.of(context).pop(),
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
                                    onPressed: () => _launchURLBrowser('alex')
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
                                          textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20, color: Colors.white),
                                          onPressed: () => _launchURLBrowser('xutao')
                                          )
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
                                          textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20, color: Colors.white),
                                          onPressed: () => _launchURLBrowser('james'))
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
                                          textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20, color: Colors.white),
                                          onPressed: () => _launchURLBrowser('jacob'))
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
                                          textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20, color: Colors.white),
                                          onPressed: () => _launchURLBrowser('golden'))
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
                                        textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20, color: Colors.white),
                                        onPressed: () => _launchURLBrowser('alperen')),
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
                                          textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20, color: Colors.white),
                                          onPressed: () => _launchURLBrowser('tony'))
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
              
              Expanded(
                child: Button(
                  placeholderText: 'Github',
                  backgroundColor: Theme.of(context).focusColor,
                  textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20, color: Colors.white), 
                  onPressed: () => _launchURLBrowser('')
                ),
              )
            
            ]
          ),
        )
      )
    );
  }
}