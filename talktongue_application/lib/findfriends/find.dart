import 'dart:convert';
//import 'dart:math';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/mydrawer.dart';
import 'package:talktongue_application/shared/serverconfig.dart';
//import 'package:talktongue_application/view/main.dart';

//void main() => runApp(const FindFriends());

class FindFriends extends StatefulWidget {
  const FindFriends({super.key, required this.userdata});
  final User userdata;

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
                      child: ListView.builder(
                    itemCount: acclist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Image.network(
                              "${ServerConfig.server}/talktongue/assets/profile/${acclist[index].userid}.png"),
                        ),
                        //Text("Available ${bookList[index].bookQty} unit"),
                        title: Text(
                            truncateString(acclist[index].username.toString())),
                        //subtitle: Text("${acclist[index].username}"),
                        onTap: () {
                          // Handle tapping on the account profile
                          // For example, navigate to profile details page
                        },
                      );
                    },
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
    http
        .get(
      Uri.parse(
          "${ServerConfig.server}/talktongue/php/load_users.php?name=$name"),
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
