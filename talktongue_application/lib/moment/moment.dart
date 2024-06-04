import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/moment/mymoments.dart';
import 'package:talktongue_application/shared/mydrawer.dart';
import 'package:talktongue_application/shared/serverconfig.dart';
//import 'package:talktongue_application/view/main.dart';

//void main() => runApp(const Moment());

class Moment extends StatefulWidget {
  final User userdata;
  final Post post;
  const Moment({super.key, required this.userdata, required this.post});

  @override
  State<Moment> createState() => _MomentState();
}

class _MomentState extends State<Moment> {
  late double screenWidth, screenHeight;
  final df = DateFormat('hh:mm a   dd/MM/yyyy');
  //var val = 50;
  bool isDisable = false;
  Random random = Random();
  final _formKey = GlobalKey<FormState>();
  List<Post> postList = <Post>[];
  List<User> userlist = <User>[];
  int numofpage = 1;
  int curpage = 1;
  int numofresult = 0;
  var color;

  bool clickedCentreFAB = false;

  get floatingActionButton => null;

  TextEditingController postController = TextEditingController();
  String deets = "";
  int axiscount = 2;

  get onSelected => null;

  @override
  void initState() {
    super.initState();
    loadPost(deets);
    if (widget.userdata.userid == widget.post.userId) {
      isDisable = true;
    } else {
      isDisable = false;
    }
  }

  Future<void> _refresh() async {
    // Handle your refresh logic here
    loadPost(deets);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }

    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
            //primarySwatch: Colors.pink,
            colorSchemeSeed: const Color.fromARGB(197, 233, 179, 207)),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Moments"),
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
                  const PopupMenuItem<int>(
                    value: 0,
                    //onTap: my_moments,
                    child: Text('My Moments'),
                  ),
                ],
              ),
            ],
          ),
          drawer: MyDrawer(
            page: "books",
            userdata: widget.userdata,
            post: widget.post,
          ),
          backgroundColor: const Color.fromARGB(197, 233, 179, 207),
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                  width: 50,
                ),
                Container(
                  height: screenHeight * 0.83,
                  child: postList.isEmpty //|| userlist.isEmpty
                      ? const Center(child: Text("No post available"))
                      : ListView.separated(
                          itemCount: postList.length,
                          itemBuilder: (context, index) {
                            /*  if (index >= userlist.length) {
                              return const SizedBox.shrink();
                            } */
                            return ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: screenWidth * 0.8),
                              child: SizedBox(
                                width: screenWidth * 0.8,
                                child: ListTile(
                                  leading: CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: Image.network(
                                          "${ServerConfig.server}/talktongue/assets/profile/${postList[index].userId}.png",
                                          // "${ServerConfig.server}/talktongue/assets/profile/${widget.userdata.userid}.png",
                                        ),
                                      )),
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /* Text(truncateString(
                                          userlist[index].username.toString())), */
                                      Text(truncateString(
                                          postList[index].username.toString())),
                                      Text(
                                        df.format(DateTime.parse(postList[index]
                                            .postDate
                                            .toString())),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black38),
                                      )
                                    ],
                                  ),
                                  subtitle: Text(truncateString(
                                      postList[index].postDeets.toString())),

                                  isThreeLine: true,
                                  //dense: true,
                                  onTap: () async {
                                    Post post =
                                        Post.fromJson(postList[index].toJson());
                                  },
                                ),
                              ),
                            );

                            /* return ListTile(
                                          title: Text(truncateString(
                                              postList[index].postDeets.toString())), */
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                                /* thickness: 2,
                                    height: 20, */
                                );
                          },
                        ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
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
                            loadPost(deets);
                          },
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color, fontSize: 18),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  handleClick(int item) {
    switch (item) {
      case 0:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (content) => Mymoments(
                      userdata: widget.userdata,
                      post: widget.post,
                    )));
        break;
      case 1:
        break;
    }
  }

  void loadPost(String deets) {
    //String userid = "all";
    String username = widget.post.username.toString();
    http
        .get(
      Uri.parse(
          "${ServerConfig.server}/talktongue/php/load_moments.php?username=$username&deets=$deets&pageno=$curpage"),
    )
        .then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          postList.clear();
          if (data['data']['posts'] != null) {
            data['data']['posts'].forEach((v) {
              postList.add(Post.fromJson(v));
            });
            numofpage = int.parse(data['numofpage'].toString());
            numofresult = int.parse(data['numberofresult'].toString());
          }
        } else {
          //if no status failed
          postList.clear();
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

  /*  void my_moments() {
    Navigator.of(context).pop();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (content) => Mymoments(
                  userdata: widget.userdata,
                )));
  } */
}
