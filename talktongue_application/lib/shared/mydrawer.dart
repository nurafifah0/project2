import 'package:flutter/material.dart';
import 'package:talktongue_application/accsetting/settingacc.dart';
import 'package:talktongue_application/findfriends/find.dart';
import 'package:talktongue_application/learning/learn.dart';
import 'package:talktongue_application/message/chat.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/moment/moment.dart';
import 'package:talktongue_application/shared/EnterExitRoute.dart';
import 'package:talktongue_application/shared/serverconfig.dart';
import 'package:talktongue_application/view/splashscreen.dart';

class MyDrawer extends StatefulWidget {
  final String page;
  final User userdata;
  final Post post;

  const MyDrawer(
      {Key? key,
      required this.page,
      required this.userdata,
      required this.post})
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
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 105, 29, 67),
            ),
            currentAccountPicture: /* CircleAvatar(
                radius: 30.0,
                // AssetImage('assets/images/pr.jpeg'),

                backgroundColor: Colors.white,
                child: ClipOval(
                  child: widget.userdata.userid != null
                      ? Image.network(
                          "${ServerConfig.server}/talktongue/assets/profile/${widget.userdata.userid}.png",
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error);
                          },
                        )
                      : Icon(Icons.error),
                )), */
                Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: widget.userdata.userid != null
                      ? NetworkImage(
                          "${ServerConfig.server}/talktongue/assets/profile/${widget.userdata.userid}.png",
                        )
                      : const Icon(Icons.error) as ImageProvider,
                  /* : const AssetImage(
                                            "assets/images/profile.jpg")
                                        as ImageProvider, */
                  fit: BoxFit.cover,
                  onError: (error, stackTrace) {
                    print("Error loading image: $error");
                  },
                ),
              ),
            ),
            accountName: Text(
              widget.userdata.username.toString(),
              style: const TextStyle(fontSize: 17),
            ),
            accountEmail: const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /* Text(
                      widget.userdata.username.toString(),
                      style: const TextStyle(fontSize: 17),
                    ), */
                    Text(
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
                              builder: (content) => Moment(
                                    userdata: widget.userdata,
                                    post: widget.post,
                                  )));

                      print(widget.page.toString());
                      if (widget.page.toString() == "books") {
                        Navigator.pop(context);
                        return;
                      }
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          EnterExitRoute(
                              exitPage: Moment(
                                userdata: widget.userdata,
                                post: widget.post,
                              ),
                              enterPage: Moment(
                                userdata: widget.userdata,
                                post: widget.post,
                              )));
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
                              builder: (content) => Chat(
                                    userdata: widget.userdata,
                                    post: widget.post,
                                  )));
                      Navigator.push(
                          context,
                          EnterExitRoute(
                              exitPage: Chat(
                                userdata: widget.userdata,
                                post: widget.post,
                              ),
                              enterPage: Chat(
                                userdata: widget.userdata,
                                post: widget.post,
                              )));
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
                              builder: (content) => FindFriends(
                                    userdata: widget.userdata,
                                    post: widget.post,
                                  )));
                      Navigator.push(
                          context,
                          EnterExitRoute(
                              exitPage: FindFriends(
                                userdata: widget.userdata,
                                post: widget.post,
                              ),
                              enterPage: FindFriends(
                                userdata: widget.userdata,
                                post: widget.post,
                              )));
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
                              builder: (content) => LearningResources(
                                    userdata: widget.userdata,
                                    post: widget.post,
                                  )));
                      Navigator.push(
                          context,
                          EnterExitRoute(
                              exitPage: LearningResources(
                                userdata: widget.userdata,
                                post: widget.post,
                              ),
                              enterPage: LearningResources(
                                userdata: widget.userdata,
                                post: widget.post,
                              )));
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
                              builder: (content) => AccountSetting(
                                    userdata: widget.userdata,
                                    //user: widget.userdata,
                                    post: widget.post,
                                  )));
                      Navigator.push(
                          context,
                          EnterExitRoute(
                              exitPage: AccountSetting(
                                userdata: widget.userdata,
                                // user: widget.userdata,
                                post: widget.post,
                              ),
                              enterPage: AccountSetting(
                                userdata: widget.userdata,
                                // user: widget.userdata,
                                post: widget.post,
                              )));
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
