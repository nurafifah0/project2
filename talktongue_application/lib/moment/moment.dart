import 'package:flutter/material.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/moment/mymoments.dart';
import 'package:talktongue_application/shared/mydrawer.dart';
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
  bool clickedCentreFAB = false;

  get floatingActionButton => null;

  @override
  Widget build(BuildContext context) {
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
        body: const SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                Text("hello world"),
                SizedBox(
                  height: 30,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
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
