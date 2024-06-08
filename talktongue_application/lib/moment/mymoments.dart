import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/moment/moment.dart';
import 'package:talktongue_application/shared/serverconfig.dart';
//import 'package:talktongue_application/view/main.dart';

//void main() => runApp(const Moment());

class Mymoments extends StatefulWidget {
  final User userdata;
  final Post post;
  const Mymoments({super.key, required this.userdata, required this.post});

  @override
  State<Mymoments> createState() => _MymomentsState();
}

class _MymomentsState extends State<Mymoments> {
  late double screenWidth, screenHeight;
  File? _image;
  //var pathAsset = "assets/images/profile.png";
  final df = DateFormat('hh:mm a   dd/MM/yyyy');
  //var val = 50;
  bool isDisable = false;
  Random random = Random();
  final _formKey = GlobalKey<FormState>();
  List<Post> postList = <Post>[];
  //List<User> userlist = <User>[];
  int numofpage = 1;
  int curpage = 1;
  int numofresult = 0;
  var color;

  bool clickedCentreFAB = false;

  get floatingActionButton => null;

  TextEditingController postController = TextEditingController();
  String deets = "";

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
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
          //primarySwatch: Colors.pink,
          colorSchemeSeed: const Color.fromARGB(197, 233, 179, 207)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My Moments"),
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
                      builder: (content) => Moment(
                            userdata: widget.userdata,
                            post: widget.post,
                          )));
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(197, 233, 179, 207),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Container(
                          height: screenHeight * 0.3,
                          width: screenWidth,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/n.jpg"),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                        width: 50,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          /* CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image.network(
                                  "${ServerConfig.server}/talktongue/assets/profile/${widget.userdata.userid}.png",
                                ),
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
                                    : const AssetImage(
                                            "assets/images/profile.jpg")
                                        as ImageProvider,
                                fit: BoxFit.cover,
                                onError: (error, stackTrace) {
                                  print("Error loading image: $error");
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        /*  height: 60,
                        width: 500, */
                        child: Text(
                          widget.userdata.username
                              .toString()
                              .toUpperCase()
                              .padLeft(10),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.values.first,
                          //textAlign: TextAlign.end
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        // textAlign: TextAlign.center,
                        onFieldSubmitted: (v) {},
                        controller: postController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "New post (what's new )",
                            hintText: "e.g Hi Good Morning",
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            // prefixText: '\$: ',
                            //icon: Icon(Icons.cancel,color: _username.text.isNotEmpty ? Colors.grey : Colors.transparent )
                            suffixIcon: IconButton.filled(
                                onPressed: _sent,
                                icon: Icon(Icons.send,
                                    color: postController.text.isNotEmpty
                                        ? Colors.blueGrey
                                        : Colors.black)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      Container(
                        height: screenHeight * 0.035,
                        alignment: Alignment.center,
                        //color: Colors.blue,
                        width: screenWidth,
                        child: const Text("Recently Post(s)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromARGB(255, 56, 49, 49),
                                fontWeight: FontWeight.bold)),
                      ),
                      const Divider(
                        color: Colors.black12,
                      ),
                      /* SizedBox(
                        height: screenHeight * 0.28,
                        child: postList.isEmpty
                            ? const Center(child: Text("No post available"))
                            : ListView.separated(
                                itemCount: postList.length,
                                itemBuilder: (context, index) {
                                  //if (widget.post.userId ==widget.userdata.userid) {
                                  return ListTile(
                                    leading: /* CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: Colors.white,
                                        child: ClipOval(
                                          child: Image.network(
                                            "${ServerConfig.server}/talktongue/assets/profile/${widget.userdata.userid}.png",
                                          ),
                                        )), */
                                        Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: widget.userdata.userid != null
                                              ? NetworkImage(
                                                  "${ServerConfig.server}/talktongue/assets/profile/${widget.userdata.userid}.png",
                                                )
                                              : const Icon(Icons.error)
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                          onError: (error, stackTrace) {
                                            print(
                                                "Error loading image: $error");
                                          },
                                        ),
                                      ),
                                    ),
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(truncateString(postList[index]
                                            .username
                                            .toString())),
                                        Text(
                                          df.format(DateTime.parse(
                                              postList[index]
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
                                    trailing: //const Icon(Icons.access_time_filled_outlined),
                                        Wrap(
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
                                    ),
                                    isThreeLine: true,
                                    //dense: true,
                                    onTap: () async {
                                      Post post = Post.fromJson(
                                          postList[index].toJson());
                                    },
                                  );
                                  //}
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider(
                                      /* thickness: 2,
                              height: 20, */
                                      );
                                },
                              ),
                      ), */
                      SizedBox(
                        height: screenHeight * 0.28,
                        child: _buildPostListView(),
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPostListView() {
    // Filter the postList to only include posts where userId matches userdata.userid
    List<Post> filteredPosts = postList
        .where((post) => post.userId == widget.userdata.userid)
        .toList();

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
                image: widget.userdata.userid != null
                    ? NetworkImage(
                        "${ServerConfig.server}/talktongue/assets/profile/${widget.userdata.userid}.png",
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
          trailing: Wrap(
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
          ),
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
  }

  void _sent() {
    String postupdate = postController.text;
    //String imagestr = base64Encode(_image!.readAsBytesSync());

    http.post(
        Uri.parse("${ServerConfig.server}/talktongue/php/insert_moment.php"),
        body: {
          "userid": widget.userdata.userid.toString(),
          "name": widget.userdata.username.toString(),
          "deets": postupdate,
          //"image": imagestr
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) => Mymoments(
                        userdata: widget.userdata,
                        post: widget.post,
                      )));
        } else {
          /*  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Failed"),
            backgroundColor: Colors.red,
          )); */
        }
      }
    });
  }

  void loadPost(String deets) {
    //String userid = "all";
    // String userid = widget.userdata.userid.toString();
    String username = widget.post.username.toString();
    //userid=$userid&

    http
        .get(
      Uri.parse(
          "${ServerConfig.server}/talktongue/php/load_mymoments.php?username=$username&deets=$deets&pageno=$curpage"),
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

  void _delete() {
    http.post(
        Uri.parse("${ServerConfig.server}/talktongue/php/delete_moment.php"),
        body: {
          "userid": widget.userdata.userid.toString(),
          "postid": widget.post.postId.toString(),
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Delete Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) => Mymoments(
                        userdata: widget.userdata,
                        post: widget.post,
                      )));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Delete Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }

  void _edit() {}
}
