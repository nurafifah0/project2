import 'dart:convert';
//import 'dart:math';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:talktongue_application/accsetting/settingacc.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/mydrawer.dart';
import 'package:talktongue_application/shared/serverconfig.dart';
//import 'package:talktongue_application/view/main.dart';

//void main() => runApp(const FindFriends());

class FindFriends extends StatefulWidget {
  const FindFriends(
      {super.key,
      required this.user,
      required this.userdata,
      required this.post});
  final User user;
  final User userdata;
  final Post post;

  @override
  State<FindFriends> createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  List<User> acclist = <User>[];
  late double screenWidth, screenHeight;

  bool clickedCentreFAB = false;
  get floatingActionButton => null;
  String name = "";

  @override
  void initState() {
    super.initState();
    loadAccs(name);
    /*  loadBooks(
      "all",
    ); */
  }

  Future<void> _refresh() async {
    // Handle your refresh logic here
    loadAccs(name);
  }

  int axiscount = 2;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }
/*     return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
          //primarySwatch: Colors.pink,
          colorSchemeSeed: const Color.fromARGB(197, 233, 179, 207)), */
    return Scaffold(
      appBar: AppBar(
          title: const Text("Find Friends"),
          titleTextStyle: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actionsIconTheme: const IconThemeData(color: Colors.black),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              iconSize: 35,
              onPressed: () {},
            )
          ]
          //static const IconData notifications = IconData(0xe44f, fontFamily: 'MaterialIcons');
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
        userdata: widget.user,
        post: widget.post,
      ),
      backgroundColor: const Color.fromARGB(197, 233, 179, 207),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: acclist.isEmpty
            ? const Center(child: Text("No Data"))
            : Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: const Text("Accounts"),
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    width: screenWidth,
                    padding: const EdgeInsets.all(4.0),
                    child: ListView.separated(
                      itemCount: acclist.length,
                      itemBuilder: (BuildContext context, index) {
                        return ListTile(
                          /* leading: CircleAvatar(
                            child: Image.network(
                                "${ServerConfig.server}/talktongue/assets/profile/${acclist[index].userid}.png"),
                          ), */
                          //Text("Available ${bookList[index].bookQty} unit"),
                          /* title: Text(truncateString(
                              acclist[index].username.toString().toUpperCase())), */
                          //subtitle: Text("${acclist[index].username}"),
                          /*   onTap: () {
                            // Handle tapping on the account profile
                            // For example, navigate to profile details page
                          }, */

                          title: InkWell(
                            onTap: () async {
                              User user =
                                  User.fromJson(acclist[index].toJson());
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (content) => AccountSetting(
                                            user: widget.user,
                                            userdata: widget.userdata,
                                            post: widget.post,
                                          )));
                              loadAccs(name);
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: acclist[index].userid != null
                                          ? Image.network(
                                              "${ServerConfig.server}/talktongue/assets/profile/${widget.userdata.userid}.png",
                                            )
                                          : const Placeholder(),
                                    )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  truncateString(
                                      acclist[index].username.toString()),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  )),
                ],
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

  void loadAccs(String name) {
    String userid = "all";
    String username = "";
    http
        .get(
      Uri.parse(
          "${ServerConfig.server}/talktongue/php/load_users.php?userid=$userid&name=$name&username=$username"),
    )
        .then((response) {
      log(response.body);
      if (response.statusCode == 200) {
        log(response.body);
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          acclist.clear();
          data['data']['users'].forEach((v) {
            acclist.add(User.fromJson(v));
          });
/*           numofpage = int.parse(data['numofpage'].toString());
          numofresult = int.parse(data['numberofresult'].toString()); */
        } else {
          //if no status failed
        }
      }
      setState(() {});
    });
  }

  String truncateString(String str) {
    if (str.length > 20) {
      str = str.substring(0, 20);
      return "$str...";
    } else {
      return str;
    }
  }
}
