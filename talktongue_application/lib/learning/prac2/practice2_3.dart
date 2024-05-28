import 'package:flutter/material.dart';
import 'package:talktongue_application/learning/learn.dart';
import 'package:talktongue_application/learning/prac2/practice2_2.dart';
import 'package:talktongue_application/models/post.dart';

import 'package:talktongue_application/models/user.dart';

import 'practice2_4.dart';

class Practice2sub3 extends StatefulWidget {
  const Practice2sub3({super.key, required this.userdata, required this.post});
  final User userdata;
  final Post post;

  @override
  State<Practice2sub3> createState() => _Practice2sub3State();
}

class _Practice2sub3State extends State<Practice2sub3> {
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
                          userdata: widget.userdata, post: widget.post)));
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
                            "QUESTION 3",
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
                            "Let’s talk about what goes inside Radio widget. Per the regular design norms, a radio button is followed by a label or a text that shows what that option constitutes, hence, after declaring new instance of Radio widget, we need to have a text widget for each radio object so that UI shows a radio button followed by a text, as shown below",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            height: 30,
                            child: RadioListTile(
                              title: const Text("Male"),
                              value: "male",
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
                            title: const Text("feMale"),
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
                          const SizedBox(
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
            builder: (content) =>
                Practice2sub2(userdata: widget.userdata, post: widget.post)));
    // const Color.fromARGB(0, 131, 138, 158);
  }

  void nextPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (content) =>
                Practice2sub4(userdata: widget.userdata, post: widget.post)));
  }

  void _result() {
    // String answer;
    answer = "the right answer is feMale";
    const Text('fnjfd');
    print(answer);
    setState(() {});
  }
}
