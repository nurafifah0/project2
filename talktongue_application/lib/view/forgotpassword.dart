import 'package:flutter/material.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/view/login.dart';
//import 'package:talktongue_application/view/main.dart';

//void main() => runApp( ForgotPasswordPage());

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({
    super.key,
  });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: BackButton(
          onPressed: () {
            //Navigator.of(context).pop();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (content) => const LoginPage()));
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(197, 233, 179, 207),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  width: 180,
                  child: Image.asset(
                    'assets/images/pic1.png',
                    alignment: const Alignment(100, 100),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const SizedBox(
                  width: 400,
                  height: 30,
                  child: Text(
                    "Forget Password",
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
                    labelText: 'recovery email',
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
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "we will send a link to reset a new password through your email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: _send,
                    child: const Text(
                      "Send",
                      style: TextStyle(
                          fontSize: 20,
                          // color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _send() {}
}
