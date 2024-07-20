// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talktongue_application/message/chatlist.dart';
import 'package:talktongue_application/models/setting.dart';
//import 'package:talktongue_application/models/setting.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/shared/serverconfig.dart';
import 'package:talktongue_application/view/forgotpassword.dart';
import 'package:talktongue_application/view/main.dart';
import 'package:http/http.dart' as http;

//void main() => runApp( LoginPage());

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  bool _passwordVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadpref();
  }

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
            padding: const EdgeInsets.all(20),
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
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  width: 400,
                  height: 30,
                  child: Text(
                    "Login",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'email',
                    labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    hintText: "    e.g john01@gmail.com",
                    //suffixText: 'Year(s)',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    icon: const Icon(Icons.email),
                    filled: true,
                    fillColor: Color.lerp(Colors.white10, Colors.white12, 25),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  // textAlign: TextAlign.center,
                  controller: newPasswordController,

                  keyboardType: TextInputType.visiblePassword,
                  // obscureText: true,
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: "e.g As21@364",
                    labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    //prefixText: '\$: ',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    icon: const Icon(Icons.lock),
                    filled: true,
                    fillColor: Color.lerp(Colors.white10, Colors.white12, 25),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                // const SizedBox(height: 30),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        saveremovepref(value!);
                        setState(() {
                          _isChecked = value;
                        });
                      },
                    ),
                    const Text(
                      "Remember Me",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 70,
                    ),
                    ElevatedButton(
                        onPressed: _reset,
                        child: const Text(
                          "Clear",
                          style: TextStyle(fontSize: 20),
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      onPressed: /*  () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (content) => const Chat()));
                      }, */
                          _loginUser,
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 500,
                  width: 400,
                  child: GestureDetector(
                    onTap: _forgotpassword,
                    child: const Text(
                      "Forgot Password?",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void _reset() {
    emailController.clear();
    newPasswordController.clear();
  }

  void _forgotpassword() {
    //
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (content) => const ForgotPasswordPage()));
  }

  void _loginUser() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    String email = emailController.text;
    String pass = newPasswordController.text;

    http.post(Uri.parse("${ServerConfig.server}/talktongue/php/login_user.php"),
        body: {"email": email, "password": pass}).then((response) {
      // print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          User user = User.fromJson(data['data']);
          Post post = Post.fromJson(data['data']);
          Setting setting = Setting.fromJson(data['data']);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Login Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) => ChatListPage(
                        currentUser: user,
                        post: post,
                        setting: setting,
                      )));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Login Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }

  void saveremovepref(bool value) async {
    String email = emailController.text;
    String password = newPasswordController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      //safe pref
      await prefs.setString('email', email);
      await prefs.setString('pass', password);
      await prefs.setBool('rem', value);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Preferences Stored"),
        backgroundColor: Colors.green,
      ));
    } else {
      //remove pref
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      await prefs.setBool('rem', false);
      emailController.text = '';
      newPasswordController.text = '';
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Preferences Removed"),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> loadpref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    _isChecked = (prefs.getBool('rem')) ?? false;
    if (_isChecked) {
      emailController.text = email;
      newPasswordController.text = password;
    }
    setState(() {});
  }
}
