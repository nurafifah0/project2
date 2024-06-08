import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:talktongue_application/findfriends/find.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/serverconfig.dart';

class AccProfile extends StatefulWidget {
  const AccProfile(
      {super.key,
      //required this.user,
      //required this.userdata,
      required this.currentUser,
      required this.targetUser,
      required this.post});
  final User currentUser;
  final User targetUser;
  //final User user;
  //final User userdata;
  final Post post;

  @override
  State<AccProfile> createState() => _AccProfileState();
}

class _AccProfileState extends State<AccProfile> {
  late double screenWidth, screenHeight;
  List<Post> postList = <Post>[];
  final df = DateFormat('hh:mm a   dd/MM/yyyy');
  int numofpage = 1;
  int curpage = 1;
  int numofresult = 0;

  bool isDisable = false;

/*    @override
  void initState() {
    super.initState();
    loadBooks(title);
    /*  loadBooks(
      "all",
    ); */
  } */

  @override
  void initState() {
    super.initState();
    loadPosts();
    /* if (widget.userdata.userid == widget.post.userId) {
      isDisable = true;
    } else {
      isDisable = false;
    } */
  }

  Future<void> _refresh() async {
    // Handle your refresh logic here
    loadPosts();
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
            title: const Text("Find Language Partner"),
            titleTextStyle: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: BackButton(
              onPressed: () {
                //Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => FindFriends(
                              userdata: widget.currentUser,
                              post: widget.post,
                            )));
              },
            ),
          ),
          backgroundColor: const Color.fromARGB(197, 233, 179, 207),
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        /* Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                              "${ServerConfig.server}/talktongue/assets/profile/${widget.targetUser.userid}.png",
                            )),
                          ),
                        ), */
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: widget.targetUser.userid != null
                                  ? NetworkImage(
                                      "${ServerConfig.server}/talktongue/assets/profile/${widget.targetUser.userid}.png",
                                    )
                                  : const AssetImage(
                                          'assets/images/default.png')
                                      as ImageProvider,
                              fit: BoxFit.cover,
                              onError: (error, stackTrace) {
                                print("Error loading image: $error");
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.targetUser.username.toString().toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.right,
                          //textAlign: TextAlign.end
                        ),
                        Text(
                          widget.targetUser.useremail.toString().toLowerCase(),
                          style: const TextStyle(
                              fontSize: 14, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.right,
                          //textAlign: TextAlign.end
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("ENG"),
                            // Icon(Icons.switch_access_shortcut_add_rounded),
                            Icon(Icons.arrow_circle_right),
                            Text("ESP"),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Fluency LAnguage : "),
                            Text("Beginner"),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                  const Row(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 50,
                      ),
                      Text(
                        "MOMENTS : ",
                        //textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  /*SizedBox(
                height: screenHeight * 0.28,
                child: _buildPostListView(),
              ), */
                  postList.isEmpty
                      ? const Center(child: Text("No post available"))
                      : ListView.separated(
                          shrinkWrap: true,
                          //physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: postList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(postList[index].username ?? ""),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Posted on ${df.format(DateTime.parse(postList[index].postDate ?? ""))}'),
                                  Text(
                                    postList[index].postDeets ?? "",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                        ),
                ],
              ),
            ),
          )),
    );
  }
/* 
  Widget _buildPostListView() {
    // Filter the postList to only include posts where userId matches userdata.userid
    List<Post> filteredPosts =
        postList.where((post) => post.userId == widget.user.userid).toList();

    if (filteredPosts.isEmpty) {
      return const Center(child: Text("No post available"));
    }

    return ListView.separated(
      itemCount: filteredPosts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: widget.user.userid != null
                    ? NetworkImage(
                        "${ServerConfig.server}/talktongue/assets/profile/${widget.user.userid}.png",
                      )
                    : const Icon(Icons.error) as ImageProvider,
                fit: BoxFit.cover,
                onError: (error, stackTrace) {
                  print("Error loading image: $error");
                },
              ),
            ),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(truncateString(filteredPosts[index].username.toString())),
              Text(
                df.format(
                    DateTime.parse(filteredPosts[index].postDate.toString())),
                style: const TextStyle(fontSize: 15, color: Colors.black38),
              ),
            ],
          ),
          subtitle:
              Text(truncateString(filteredPosts[index].postDeets.toString())),
          /* trailing: Wrap(
            spacing: -16,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: _edit,
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
                onPressed: _delete,
              ),
            ],
          ), */
          isThreeLine: true,
          onTap: () async {
            Post post = Post.fromJson(filteredPosts[index].toJson());
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  } */

  String truncateString(String str) {
    if (str.length > 20) {
      str = str.substring(0, 20);
      return "$str...";
    } else {
      return str;
    }
  }

  void loadPosts() {
    http
        .get(
      Uri.parse(
          "${ServerConfig.server}/talktongue/php/load_momentaccprofile.php?userid=${widget.targetUser.userid}"),
    )
        .then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          postList.clear();
          if (data['data']['posts'] != null) {
            data['data']['posts'].forEach((v) {
              postList.add(Post.fromJson(v));
            });
          }
        } else {
          postList.clear();
        }
      }
      setState(() {});
    });
  }
}
