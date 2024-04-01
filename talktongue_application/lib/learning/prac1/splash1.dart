import 'dart:async';
import 'package:flutter/material.dart';
import 'package:talktongue_application/learning/learn.dart';
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

class Splash1 extends StatefulWidget {
  const Splash1({Key? key, required this.userdata}) : super(key: key);
  final User userdata;

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (content) =>
                  LearningResources(userdata: widget.userdata))),
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
              Text("goodjob"),
              Text("data"),
            ],
          ),
        ));
  }
}
