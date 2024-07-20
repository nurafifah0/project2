import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/serverconfig.dart';

class EmailChange extends StatefulWidget {
  final User userdata;

  const EmailChange({
    super.key,
    required this.userdata,
  });

  @override
  State<EmailChange> createState() => _EmailChangeState();
}

class _EmailChangeState extends State<EmailChange> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //CircleAvatar(backgroundImage: AssetImage('')),
            Text(
              "Change My Email",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 40,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        /*  bottom: PreferredSize(
              preferredSize: const Size.fromHeight(5.0),
              child: Container(
                color: Colors.grey,
                height: 1.0,
              ),
            ) */
      ),
      backgroundColor: const Color.fromARGB(197, 233, 179, 207),
      body: SingleChildScrollView(
        child: RefreshIndicator(
            onRefresh: () async {
              // loadChatUsers();
            },
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Email :",
                        style: TextStyle(
                            fontSize: 40.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Card(
                      color: Color.fromARGB(69, 249, 12, 186),
                      elevation: 10,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "Current Email: ",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.userdata.useremail.toString(),
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ))),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                icon: Icon(Icons.email),
                              ),
                              validator: (val) => val!.isEmpty ||
                                      !val.contains("@") ||
                                      !val.contains(".")
                                  ? "Please enter a valid email"
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: _updateEmail,
                    child: Text("Update Email"),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  String truncateString(String str) {
    if (str.length > 20) {
      str = str.substring(0, 20);
      return "$str...";
    } else {
      return str;
    }
  }

  Future<void> _updateEmail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String newEmail = _emailController.text;
    String userId = widget.userdata.userid!;

    var url =
        Uri.parse("${ServerConfig.server}/talktongue/php/update_email.php");
    var response = await http.post(url, body: {
      'userid': userId,
      'newemail': newEmail,
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 'success') {
        // Update the user email in the app
        setState(() {
          widget.userdata.useremail = newEmail;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email updated successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update email")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating email")),
      );
    }
  }
}
