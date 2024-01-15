import 'package:flutter/material.dart';
import 'package:talktongue_application/message/contactlist.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/mydrawer.dart';
//import 'package:talktongue_application/view/main.dart';

//void main() => runApp(const Chat());

class Chat extends StatefulWidget {
  const Chat({super.key, required this.userdata});
  final User userdata;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
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
          title: const Text("Chats"),
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
          actions: <Widget>[
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(value: 0, child: Text('Pin Chat')),
                const PopupMenuItem<int>(value: 1, child: Text('Delete Chat')),
              ],
            ),
          ],
        ),
        drawer: MyDrawer(
          page: "chat",
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
        floatingActionButton: FloatingActionButton(
          onPressed: ()
              // FloatingActionButtonLocation.centerDocked;
              {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (content) => ContactList(
                          userdata: widget.userdata,
                        )));
          },

          tooltip: 'Add',
          //heroTag: 'uniqueTag',
          child: const Icon(Icons.add),
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

  additem(item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
    }
  }
}
