import 'package:flutter/material.dart';
import 'package:talktongue_application/message/contactlist.dart';
import 'package:talktongue_application/models/user.dart';

class GroupChat extends StatefulWidget {
  const GroupChat({super.key, required this.userdata});
  final User userdata;

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
            //primarySwatch: Colors.pink,
            colorSchemeSeed: const Color.fromARGB(197, 233, 179, 207)),
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Group Chat",
              textAlign: TextAlign.center,
            ),
            titleTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              //fontStyle: FontStyle.italic
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
                        builder: (content) => ContactList(
                              userdata: widget.userdata,
                            )));
              },
            ),
          ),
          backgroundColor: const Color.fromARGB(197, 233, 179, 207),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: const Column(
                    /*  mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, */
                    children: [
                      /* Card(
                          color: const Color.fromARGB(69, 0, 0, 0),
                          elevation: 500,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.group),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "new group",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )), */
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 400,
                        height: 50,
                        child: Text(
                          "Contact List:",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),

                      //add from friendlist from database
                    ],
                  )),
            ),
          ),
        ));
  }

/*   void _cccc() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (content) => const Chat()));
  } */
}
