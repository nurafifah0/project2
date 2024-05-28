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
  final df = DateFormat('dd/MM/yyyy');
  var val = 50;
  bool isDisable = false;
  Random random = Random();
  final _formKey = GlobalKey<FormState>();
  List<Post> postList = <Post>[];
  int numofpage = 1;
  int curpage = 1;
  int numofresult = 0;
  var color;

  bool clickedCentreFAB = false;

  get floatingActionButton => null;

  TextEditingController postController = TextEditingController();
  String deets = "";

  @override
  void initState() {
    super.initState();
    loadPost(deets);
    if (widget.userdata.userid == "0") {
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
                          CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image.network(
                                  "${ServerConfig.server}/talktongue/assets/profile/${widget.userdata.userid}.png",
                                ),
                              )),
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
                              .toString()
                              .padLeft(7),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.values.first,
                          //textAlign: TextAlign.end
                        ),
                      ),
                      TextFormField(
                        // textAlign: TextAlign.center,
                        controller: postController,
                        keyboardType: TextInputType.name,
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
                      SizedBox(
                        height: screenHeight * 0.28,
                        child: /* postList.isEmpty
                            ? const Center(child: Text("No post available"))
                            : */
                            ListView.separated(
                          itemCount: postList.length,
                          //scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(widget.userdata.username.toString()),
                              subtitle: Text(truncateString(
                                  postList[index].postDeets.toString())),
                              /* trailing: //const Icon(Icons.access_time_filled_outlined),
                                  Text(df.format(DateTime.parse(
                                      widget.post.postDate.toString()))), */
                              onTap: () async {
                                Post post =
                                    Post.fromJson(postList[index].toJson());
                              },
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
              ),
            ),
          ),
        ),
      ),
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
    http
        .get(
      Uri.parse(
          "${ServerConfig.server}/talktongue/php/load_moments.php?deets=$deets&pageno=$curpage"),
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
}
