import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/mydrawer.dart';

//void main() => runApp(const AccountSetting());

class Learnings extends StatefulWidget {
  const Learnings({super.key, required this.userdata, required this.post});
  final User userdata;
  final Post post;

  @override
  State<Learnings> createState() => _LearningsState();
}

class _LearningsState extends State<Learnings> {
  bool clickedCentreFAB = false;

  get floatingActionButton => null;
  late double screenWidth, screenHeight;

/*   void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } */

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

/*   void _launchURL(String url) async {
    final googleUrl = Uri(
      scheme: 'https',
      host: 'www.google.com',
      queryParameters: {
        'q': url,
      },
    );
    if (await canLaunch(googleUrl.toString())) {
      await launch(googleUrl.toString(),
          forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  } */

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
        ),
        drawer: MyDrawer(
          page: "learning",
          userdata: widget.userdata,
          post: widget.post,
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
                        //https://uwm.edu/language-resource-center/resources/spanish/grammar-quizzes/
                        _launchURL(
                            'https://uwm.edu/language-resource-center/resources/spanish/grammar-quizzes/');
                      },
                      child: Card(
                          child: Row(children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.4,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/room.jpg"),
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
                                  "GRAMÁTICA 1 ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "GRAMMAR 1 (BEGINNER) ",
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
                        _launchURL(
                            'https://uwm.edu/language-resource-center/resources/spanish/grammar-quizzes');
                      },
                      child: Card(
                          child: Row(children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.4,
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
                                  " GRAMÁTICA 2  ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "   GRAMMAR 2  ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "  (INTERMEDIATE)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            )),
                      ])),
                    )),
                Container(
                    height: screenHeight * 0.25,
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                      onTap: () {
                        _launchURL(
                            'https://uwm.edu/language-resource-center/resources/spanish/grammar-quizzes');
                      },
                      child: Card(
                          child: Row(children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.4,
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
                                  "VOCABULARIO ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "VOCABULARY ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                )
                              ],
                            )),
                      ])),
                    )),
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
}
