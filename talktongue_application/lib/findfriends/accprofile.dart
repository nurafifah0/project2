import 'package:flutter/material.dart';
import 'package:talktongue_application/findfriends/find.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/serverconfig.dart';

class AccProfile extends StatefulWidget {
  const AccProfile(
      {super.key,
      required this.user,
      //required this.userdata,
      required this.post});
  final User user;
  //final User userdata;
  final Post post;

  @override
  State<AccProfile> createState() => _AccProfileState();
}

class _AccProfileState extends State<AccProfile> {
  late double screenWidth, screenHeight;

/*    @override
  void initState() {
    super.initState();
    loadBooks(title);
    /*  loadBooks(
      "all",
    ); */
  } */

  Future<void> _refresh() async {
    // Handle your refresh logic here
    //loadPost(deets);
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
                              userdata: widget.user,
                              post: widget.post,
                            )));
              },
            ),
          ),
          backgroundColor: const Color.fromARGB(197, 233, 179, 207),
          body: SingleChildScrollView(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  /*  CircleAvatar(
                      radius: 100.0,
                      // AssetImage('assets/images/pr.jpeg'),

                      backgroundColor: const Color.fromARGB(197, 233, 179, 207),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(99),
                          child: widget.user.userid != null
                              ? SizedBox(
                                  child: Image.network(
                                    "${ServerConfig.server}/talktongue/assets/profile/${widget.user.userid}.png",
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.error);
                                    },
                                  ),
                                )
                              : Icon(Icons.error),
                        ),
                      )), */
                  /*  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/room.jpg"),
                      ),
                    ),
                  ), */

                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: widget.user.userid != null
                            ? NetworkImage(
                                "${ServerConfig.server}/talktongue/assets/profile/${widget.user.userid}.png",
                              )
                            : const AssetImage('assets/images/default.png')
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
            ),
          ))),
    );
  }
}
