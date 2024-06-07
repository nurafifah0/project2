import 'dart:convert';

import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:talktongue_application/findfriends/accprofile.dart';

import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/mydrawer.dart';
import 'package:talktongue_application/shared/serverconfig.dart';
//import 'package:talktongue_application/view/main.dart';

//void main() => runApp(const FindFriends());

class FindFriends extends StatefulWidget {
  const FindFriends({super.key, required this.userdata, required this.post});
  final User userdata;
  final Post post;

  @override
  State<FindFriends> createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  List<User> acclist = <User>[];
  late double screenWidth, screenHeight;

  //var val = 50;
  bool isDisable = false;
  Random random = Random();
  final _formKey = GlobalKey<FormState>();

  int numofpage = 1;
  int curpage = 1;
  int numofresult = 0;
  var color;

  bool clickedCentreFAB = false;
  get floatingActionButton => null;
  String username = "";
  TextEditingController searchctlr = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAccs(username);
    /*  loadBooks(
      "all",
    ); */
  }

  Future<void> _refresh() async {
    // Handle your refresh logic here
    loadAccs(username);
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
        userdata: widget.userdata,
        post: widget.post,
      ),
      backgroundColor: const Color.fromARGB(197, 233, 179, 207),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: acclist.isEmpty
            ? const Center(child: Text("No Data"))
            : Column(
                children: [
                  SizedBox(
                    height: 49,
                    width: 300,
                    child: TextFormField(
                      // textAlign: TextAlign.center,

                      onFieldSubmitted: (v) {},
                      controller: searchctlr,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "e.g John",
                        labelStyle:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        floatingLabelStyle:
                            const TextStyle(color: Colors.purple),
                        // prefixText: '\$: ',
                        //icon: Icon(Icons.cancel,color: _username.text.isNotEmpty ? Colors.grey : Colors.transparent )
                        hintStyle: const TextStyle(
                          color: Colors.brown,
                          fontSize: 18,
                        ),
                        suffixIcon: IconButton.filled(
                          icon: Icon(Icons.search_outlined,
                              color: searchctlr.text.isNotEmpty
                                  ? Colors.blueGrey
                                  : Colors.black),
                          onPressed: //_search,
                              () {
                            TextEditingController searchctlr =
                                TextEditingController();
                            username = searchctlr.text;

                            loadAccs(searchctlr.text);
                            Navigator.of(context).pop();
                            /* Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (content) => FindFriends(
                                          userdata: widget.userdata,
                                          post: widget.post,
                                        ))); */
                          },
                          // iconSize: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        //contentPadding: EdgeInsets.symmetric(vertical: 40.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                    width: 50,
                  ),
                  Container(
                    height: screenHeight * 0.8,
                    child: ListView.separated(
                      itemCount: acclist.length,
                      itemBuilder: (context, index) {
                        /*  if (index >= userlist.length) {
                              return const SizedBox.shrink();
                            } */
                        return ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: screenWidth * 0.5),
                          child: SizedBox(
                            width: screenWidth * 0.5,
                            child: ListTile(
                              leading: CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: acclist[index].userid != null
                                        ? Image.network(
                                            "${ServerConfig.server}/talktongue/assets/profile/${acclist[index].userid}.png",
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Icon(Icons.error);
                                            },
                                          )
                                        : Icon(Icons.error),
                                  )),
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /* Text(truncateString(
                                          userlist[index].username.toString())), */
                                  Text(truncateString(
                                      acclist[index].username.toString())),
                                ],
                              ),
                              onTap: () async {
                                User user =
                                    User.fromJson(acclist[index].toJson());
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) => AccProfile(
                                              user: user,
                                              post: widget.post,
                                              //userdata: widget.userdata,

                                              //userdata: widget.userdata,
                                            )));
                                loadAccs(username);
                              },
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
                  ),
                  /* SizedBox(
              height: screenHeight * 1,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: numofpage,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  //build the list for textbutton with scroll
                  if ((curpage - 1) == index) {
                    //set current page number active
                    color = Colors.red;
                  } else {
                    color = Colors.black;
                  }
                  return TextButton(
                      onPressed: () {
                        curpage = index + 1;
                        loadAccs(username);
                      },
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(color: color, fontSize: 18),
                      ));
                },
              ),
            ), */
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

  void loadAccs(String username) {
    //String userid = "all";
    //String userid = widget.user.userid.toString();
    // String username = widget.user.username.toString();
    http
        .get(
      Uri.parse(
          "${ServerConfig.server}/talktongue/php/load_users.php?username=$username&pageno=$curpage"),
    )
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
          /*  numofpage = data['numofpage'];
          numofresult = data['numberofresult']; */
        } else {
          //if no status failed
          acclist.clear();
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

  void _search() {
    TextEditingController searchctlr = TextEditingController();
    username = searchctlr.text;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: const Text(
              "Search ",
              style: TextStyle(),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: searchctlr,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    loadAccs(searchctlr.text);
                  },
                  child: const Text("Search"),
                )
              ],
            ));
      },
    );
    /*  username = searchctlr.text;
    Navigator.of(context).pop();
    loadAccs(searchctlr.text); */
  }
}
