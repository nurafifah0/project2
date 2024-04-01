import 'package:flutter/material.dart';
//import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/view/login.dart';
import 'package:talktongue_application/view/signup.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          //primarySwatch: Colors.pink,
          colorSchemeSeed: const Color.fromARGB(197, 233, 179, 207)),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(197, 233, 179, 207),
      /*  appBar: AppBar(
        title: const Text('Talk Tongue App'),
      ), */
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /*  const SizedBox(
              height: 100,
              width: 50,
            ), */
            Image.asset(
              // ignore: prefer_const_constructors
              'assets/images/pic1.png', alignment: Alignment(100, 100),
              //height: 100, width: 100,
              // scale: 1,
            ),
            const SizedBox(
              height: 50,
              //width: 10,
            ),
            Row(
              children: [
                const SizedBox(
                    //height: 50,
                    // width: 5,
                    ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const LoginPage();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text(
                    "   Login   ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  //height: 5,
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const SignUpPage();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text(
                    "  Sign Up  ",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
