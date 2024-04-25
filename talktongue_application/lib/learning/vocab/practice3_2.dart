import 'package:flutter/material.dart';
import 'package:talktongue_application/learning/learn.dart';
import 'package:talktongue_application/learning/vocab/practice3.dart';
import 'package:talktongue_application/models/user.dart';

import 'practice3_3.dart';

class Practice3sub2 extends StatefulWidget {
  const Practice3sub2({super.key, required this.userdata});
  final User userdata;

  @override
  State<Practice3sub2> createState() => _Practice3sub2State();
}

class _Practice3sub2State extends State<Practice3sub2> {
  late double screenWidth, screenHeight;
  String? gender;
  String answer = "";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
          //primarySwatch: Colors.pink,
          colorSchemeSeed: const Color.fromARGB(197, 233, 179, 207)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "LIVING ROOM",
            textAlign: TextAlign.center,
          ),
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          /* bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey,
              height: 1.0,
            ),
          ), */
          leading: BackButton(
            onPressed: () {
              //Navigator.of(context).pop();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (content) => LearningResources(
                            userdata: widget.userdata,
                          )));
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(197, 233, 179, 207),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: screenHeight * 0.75,
                    padding: const EdgeInsets.all(4),
                    child: Card(
                      color: const Color.fromARGB(69, 0, 0, 0),
                      elevation: 500,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "QUESTION 2",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Image(
                            image: AssetImage("assets/images/room.jpg"),
                          ),
                          const Text(
                            "llorar synonyms",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            height: 30,
                            child: RadioListTile(
                              title: const Text("sollozar"),
                              value: "sollozar",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                  _result();
                                });
                              },
                              activeColor: Colors.black,
                            ),
                          ),
                          RadioListTile(
                            title: const Text(" celebrar"),
                            value: "female",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                                _result();
                              });
                            },
                            activeColor: Colors.black,
                          ),
                          /* const SizedBox(
                            height: 5,
                          ), */
                          // _result(),
                          Text(answer),
                          SizedBox(
                            height: 5,
                          ),
                          /*  MaterialButton(
                            onPressed: _result,
                            color: Colors.grey,
                            child: const Text("Press ME"),
                          ),
                          Text(answer), */
                        ],
                      ),
                    ),
                  ),
                  /* const Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 75,
                                ),
                                Text(
                                  "LIVING ROOM",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            )), */

                  //const Text("~Good Luck~ 😊"),

                  Row(
                    children: [
                      const SizedBox(
                        width: 90,
                      ),
                      FloatingActionButton.small(
                        heroTag: "llalala",
                        onPressed: previousPage,
                        tooltip: 'next page',
                        foregroundColor: Colors.black,
                        //backgroundColor: Colors.grey,
                        child: const Icon(Icons.navigate_before_sharp),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      FloatingActionButton.small(
                        heroTag: "hahaha",
                        onPressed: nextPage,
                        tooltip: 'next page',
                        child: const Icon(Icons.navigate_next_sharp),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void previousPage() {
    //Null;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (content) => Practice3(
                  userdata: widget.userdata,
                )));
    // const Color.fromARGB(0, 131, 138, 158);
  }

  void nextPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (content) => Practice3sub3(
                  userdata: widget.userdata,
                )));
  }

  void _result() {
    // String answer;
    answer = "the right answer is sollozar";
    const Text('fnjfd');
    print(answer);
    setState(() {});
  }
}
