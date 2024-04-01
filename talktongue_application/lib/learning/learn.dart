import 'package:flutter/material.dart';
import 'package:talktongue_application/learning/prac1/practice1.dart';
import 'package:talktongue_application/learning/prac2/practice2.dart';
import 'package:talktongue_application/learning/prac3/practice3.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/mydrawer.dart';

//void main() => runApp(const AccountSetting());

class LearningResources extends StatefulWidget {
  const LearningResources({super.key, required this.userdata});
  final User userdata;

  @override
  State<LearningResources> createState() => _LearningResourcesState();
}

class _LearningResourcesState extends State<LearningResources> {
  bool clickedCentreFAB = false;

  get floatingActionButton => null;
  late double screenWidth, screenHeight;

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
          title: const Text("learning resources"),
          titleTextStyle: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          /* leading: BackButton(
            onPressed: () {
              //Navigator.of(context).pop();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (content) => const Homepage()));
            },
          ), */
          /* actions: <Widget>[
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(value: 0, child: Text('Pin Chat')),
                const PopupMenuItem<int>(value: 1, child: Text('Delete Chat')),
              ],
            ),
          ], */
        ),
        drawer: MyDrawer(
          page: "learning",
          userdata: widget.userdata,
        ),
        backgroundColor: const Color.fromARGB(197, 233, 179, 207),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                Container(
                    height: screenHeight * 0.25,
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pop();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (content) =>
                                    Practice1(userdata: widget.userdata)));
                      },
                      child: Card(
                          child: Row(children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.4,
                          //constraints: const BoxConstraints.expand(),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/room.jpg"),
                                fit: BoxFit.cover),
                          ),
                          /*  CircleAvatar(
                          backgroundColor: Colors.purple[400],
                          radius: 108,
                          child: SizedBox(
                              child: Column(
                            children: [
                              Image.asset('assets/images/pic1.png'),
                            ],
                          )),
                        ) */

                          /* child: const Column(
                            children: [
                              Text("data"),
                              Text("data"),
                              Text("data"),
                              Text("data"),
                              Text("data"),
                              Text("data"),
                            ],
                          ), */
                        ),
                        const Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 75,
                                ),
                                Text(
                                  "SALA DE ESTAR ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "LIVING ROOM ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                ),
                              ],
                            )),
                      ])),
                    )),
                Container(
                    height: screenHeight * 0.25,
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                      onTap: () {
                        //Navigator.of(context).pop();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (content) =>
                                    Practice2(userdata: widget.userdata)));
                      },
                      child: Card(
                          child: Row(children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.4,
                          //constraints: const BoxConstraints.expand(),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/playground.jpg"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 75,
                                ),
                                Text(
                                  " PATIO DE JUEGOS  ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "PLAYGROUND",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )),
                      ])),
                    )),
                Container(
                    height: screenHeight * 0.25,
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                      onTap: () {
                        //Navigator.of(context).pop();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (content) =>
                                    Practice3(userdata: widget.userdata)));
                      },
                      child: Card(
                          child: Row(children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.4,
                          //constraints: const BoxConstraints.expand(),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/school.jpg"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 75,
                                ),
                                Text(
                                  "LA ESCUELA ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "THE SCHOOL ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                )
                              ],
                            )),
                      ])),
                    )),
                /* Container(
                    height: screenHeight * 0.25,
                    padding: const EdgeInsets.all(4),
                    child: Card(
                        child: Row(children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: screenWidth * 0.4,
                        height: screenHeight * 0.4,
                        child: const Text(""),
                      ),
                    ]))),
                Container(
                    height: screenHeight * 0.25,
                    padding: const EdgeInsets.all(4),
                    child: Card(
                        child: Row(children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: screenWidth * 0.4,
                        height: screenHeight * 0.4,
                        child: const Text(""),
                      ),
                    ]))), */
                const Text("~Good Luck~ 😊"),
                const SizedBox(
                  height: 30,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  /* handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
    }
  } */
}
