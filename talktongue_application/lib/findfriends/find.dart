import 'package:flutter/material.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/mydrawer.dart';
//import 'package:talktongue_application/view/main.dart';

//void main() => runApp(const FindFriends());

class FindFriends extends StatefulWidget {
  const FindFriends({super.key, required this.userdata});
  final User userdata;

  @override
  State<FindFriends> createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  bool clickedCentreFAB = false;

  get floatingActionButton => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
          //primarySwatch: Colors.pink,
          colorSchemeSeed: const Color.fromARGB(197, 233, 179, 207)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Find Friends"),
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
          page: "findfriends",
          userdata: widget.userdata,
        ),
        backgroundColor: const Color.fromARGB(197, 233, 179, 207),
        body: const SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                Text("hello world"),
                SizedBox(
                  height: 30,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
    }
  }
}
