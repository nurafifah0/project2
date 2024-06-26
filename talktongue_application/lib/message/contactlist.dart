import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:talktongue_application/message/chat.dart';
import 'package:talktongue_application/message/groupchat/group.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/serverconfig.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key, required this.userdata, required this.post});
  final User userdata;
  final Post post;

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  late double screenWidth, screenHeight;
  List<User> acclist = <User>[];
  String username = "";

  @override
  void initState() {
    super.initState();
    loadAccs(username);
  }

  Future<void> _refresh() async {
    // Handle your refresh logic here
    loadAccs(username);
  }

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
              "Select Contact(s)",
              textAlign: TextAlign.center,
            ),
            titleTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontStyle: FontStyle.italic),
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: BackButton(
              onPressed: () {
                //Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => Chat(
                              userdata: widget.userdata,
                              post: widget.post,
                            )));
              },
            ),
          ),
          backgroundColor: const Color.fromARGB(197, 233, 179, 207),
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Card(
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
                                    onPressed: _createGroup,
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
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
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
                    Expanded(
                      //height: screenHeight * 0.80,
                      child: ListView.separated(
                        itemCount: acclist.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "${ServerConfig.server}/talktongue/assets/profile/${acclist[index].userid}.png"),
                            ),
                            title: Text(acclist[index].username ?? ""),
                            onTap: () {
                              // Define the action to be taken on tap
                            },
                            //dense: true,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }

  void _createGroup() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (content) => GroupChat(
                  userdata: widget.userdata,
                  post: widget.post,
                )));
  }

  void loadAccs(String username) {
    http
        .get(Uri.parse(
            "${ServerConfig.server}/talktongue/php/load_users.php?username=$username"))
        .then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          acclist.clear();
          if (data['data']['users'] != null) {
            data['data']['users'].forEach((v) {
              acclist.add(User.fromJson(v));
            });
          }
        } else {
          acclist.clear();
        }
      }
      setState(() {});
    });
  }
}
