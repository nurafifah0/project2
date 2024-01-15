import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/serverconfig.dart';
import 'package:talktongue_application/view/login.dart';
import 'package:talktongue_application/view/main.dart';

//void main() => runApp(const SignUpPage(userdata:User,));

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_label
    theme:
    ThemeData(
        //primarySwatch: Colors.pink,
        colorSchemeSeed: const Color.fromARGB(197, 233, 179, 207));
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        /* bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey,
              height: 1.0,
            ),
          ), */
        leading: BackButton(
          onPressed: () {
            //Navigator.of(context).pop();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (content) => const Homepage()));
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(197, 233, 179, 207),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                SizedBox(
                  height: 180,
                  width: 180,
                  child: Image.asset(
                    'assets/images/pic1.png',
                    alignment: const Alignment(100, 100),
                  ),
                ),
                /* IconButton(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.centerLeft,
                    tooltip: 'Go back',
                    enableFeedback: true,
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      //Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const Homepage()));
                    },
                  ), */

                const SizedBox(
                  width: 400,
                  height: 50,
                  child: Text(
                    "Sign Up",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  // textAlign: TextAlign.center,
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: "e.g John",
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20),
                      // prefixText: '\$: ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'email',
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20),
                      hintText: "    e.g john01@gmail.com",
                      //suffixText: 'Year(s)',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  // textAlign: TextAlign.center,
                  controller: newPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'New Password',
                      hintText: "e.g As21@364",
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20),
                      //prefixText: '\$: ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20),
                      hintText: "e.g As21@364",
                      //suffixText: 'Year(s)',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                const SizedBox(
                  height: 70,
                  // width: 100,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 70,
                    ),
                    ElevatedButton(
                        onPressed: _reset,
                        child: const Text(
                          "Reset",
                          style: TextStyle(fontSize: 20),
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      onPressed: _registerUser,
                      /* {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => const Homepage()));
                        }, */
                      /* {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (content) => const Homepage()));
                        }, */

                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void _reset() {
    nameController.clear();
    emailController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  void _registerUser() {
    String name = nameController.text;
    String email = emailController.text;
    String pass = newPasswordController.text;

    http.post(
        Uri.parse("${ServerConfig.server}/talktongue/php/register_user.php"),
        body: {
          "name": name,
          "email": email,
          "password": pass
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        (data);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Registration Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.push(context,
              MaterialPageRoute(builder: (content) => const LoginPage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Registration Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }
}
