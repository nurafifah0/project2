import 'package:flutter/material.dart';
import 'package:talktongue_application/accsetting/settingacc.dart';
import 'package:talktongue_application/findfriends/find.dart';
import 'package:talktongue_application/learning/learn.dart';
import 'package:talktongue_application/message/chat.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/moment/moment.dart';
import 'package:talktongue_application/shared/EnterExitRoute.dart';
import 'package:talktongue_application/view/splashscreen.dart';

class MyDrawer extends StatefulWidget {
  final String page;
  final User userdata;

  const MyDrawer({Key? key, required this.page, required this.userdata})
      : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
           UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 105, 29, 67),
            ),
            currentAccountPicture: const CircleAvatar(
                foregroundImage: AssetImage('assets/images/profile.jpg'),
                backgroundColor: Colors.blue),
            accountName: Text(
              widget.userdata.username.toString(),
              style: const TextStyle(fontSize: 17),
            ),
            accountEmail:  Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                     widget.userdata.username.toString(),
                      style: const TextStyle(fontSize: 17),
                    ),
                    const Text(
                      "",
                      style: TextStyle(fontSize: 20),
                    )
                  ]),
            ),
          ),
          Container(
              height: 800,
              color: const Color.fromARGB(197, 233, 179, 207),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.view_agenda),
                    title: const Text(
                      'Moments',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) =>  Moment(userdata: widget.userdata)));

                      print(widget.page.toString());
                      if (widget.page.toString() == "books") {
                        Navigator.pop(context);
                        return;
                      }
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          EnterExitRoute(
                              exitPage:  Moment(userdata: widget.userdata),
                              enterPage:  Moment(userdata: widget.userdata)));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.chat_bubble),
                    title: const Text(
                      'Conversations',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      print(widget.page.toString());
                      if (widget.page.toString() == "chat") {
                        Navigator.pop(context);
                        return;
                      }
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) =>  Chat(userdata: widget.userdata)));
                      Navigator.push(
                          context,
                          EnterExitRoute(
                              exitPage:  Chat(userdata: widget.userdata), enterPage:  Chat(userdata: widget.userdata)));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text(
                      'Find Friends',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      print(widget.page.toString());
                      Navigator.pop(context);
                      if (widget.page.toString() == "findfriends") {
                        Navigator.pop(context);
                        return;
                      }
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) =>  FindFriends(userdata: widget.userdata)));
                      Navigator.push(
                          context,
                          EnterExitRoute(
                              exitPage:  FindFriends(userdata: widget.userdata),
                              enterPage:  FindFriends(userdata: widget.userdata)));
                    },
                  ),
                  ListTile(
                    //leading: const Icon(Icons.verified_user),
                    leading: const Icon(Icons.book),
                    title: const Text(
                      'Learning Resources',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      print(widget.page.toString());
                      Navigator.pop(context);
                      if (widget.page.toString() == "learning") {
                        Navigator.pop(context);
                        return;
                      }
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) =>  LearningResources(userdata: widget.userdata)));
                      Navigator.push(
                          context,
                          EnterExitRoute(
                              exitPage:  LearningResources(userdata: widget.userdata),
                              enterPage:  LearningResources(userdata: widget.userdata)));
                    },
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 26, 28, 30),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text(
                      'Account Settings',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      print(widget.page.toString());
                      Navigator.pop(context);
                      if (widget.page.toString() == "setting") {
                        Navigator.pop(context);
                        return;
                      }
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) =>  AccountSetting(userdata: widget.userdata)));
                      Navigator.push(
                          context,
                          EnterExitRoute(
                              exitPage:  AccountSetting(userdata: widget.userdata),
                              enterPage:  AccountSetting(userdata: widget.userdata)));
                    },
                  ),
                  /* const SizedBox(
                    height: 220,
                  ), */
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text(
                      'Logout ',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const SplashScreen1()));
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
