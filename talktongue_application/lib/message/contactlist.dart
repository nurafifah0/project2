import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:talktongue_application/message/chatlist.dart';
import 'package:talktongue_application/message/chatpage.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/setting.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/serverconfig.dart';
//import 'package:talktongue_application/view/main.dart';

class ContactListPage extends StatefulWidget {
  final User currentUser;
  final Post post;
  final Setting setting;

  const ContactListPage(
      {super.key,
      required this.currentUser,
      required this.post,
      required this.setting});

  @override
  // ignore: library_private_types_in_public_api
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<User> contactList = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  void loadContacts() async {
    final response = await http.get(
        Uri.parse("${ServerConfig.server}/talktongue/php/load_userschat.php"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        setState(() {
          contactList = (data['data']['users'] as List)
              .map((user) => User.fromJson(user))
              .toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        leading: BackButton(
          onPressed: () {
            //Navigator.of(context).pop();

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (content) => ChatListPage(
                          currentUser: widget.currentUser,
                          post: widget.post,
                          setting: widget.setting,
                        )));
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(197, 233, 179, 207),
      body: ListView.builder(
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: contactList[index].userid != null
                      ? NetworkImage(
                          "${ServerConfig.server}/talktongue/assets/profile/${contactList[index].userid}.png",
                        )
                      : const AssetImage("assets/images/profile.jpg")
                          as ImageProvider,
                  fit: BoxFit.cover,
                  onError: (error, stackTrace) {
                    print("Error loading image: $error");
                  },
                ),
              ),
            ),
            title: Text(contactList[index].username.toString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    currentUser: widget.currentUser,
                    targetUser: contactList[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
