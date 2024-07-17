import 'dart:async';
import 'package:flutter/material.dart';
import 'package:talktongue_application/learning/learn.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/user.dart';

/* 
class Splash1 extends StatelessWidget {
  const Splash1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
} */

class Splash3 extends StatefulWidget {
  const Splash3({super.key, required this.userdata, required this.post});
  final User userdata;
  final Post post;

  @override
  State<Splash3> createState() => _Splash3State();
}

class _Splash3State extends State<Splash3> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (content) => LearningResources(
                    userdata: widget.userdata,
                    post: widget.post,
                  ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromARGB(197, 233, 179, 207),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Congrats"),
              Text("...."),
            ],
          ),
        ));
  }
}
