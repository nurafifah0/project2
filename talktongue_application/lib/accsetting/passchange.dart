import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/serverconfig.dart';

class PassChange extends StatefulWidget {
  final User userdata;

  const PassChange({
    super.key,
    required this.userdata,
  });

  @override
  State<PassChange> createState() => _PassChangeState();
}

class _PassChangeState extends State<PassChange> {
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Change Password",
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
                SizedBox(height: 100),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      "Password :",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ],
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
                            controller: _oldPassController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Current Password',
                              icon: Icon(Icons.lock),
                            ),
                            validator: (val) => val!.isEmpty || (val.length < 3)
                                ? "Please enter current password"
                                : null,
                          ),
                          TextFormField(
                            controller: _newPassController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'New Password',
                              icon: Icon(Icons.lock),
                            ),
                            validator: (val) => val!.isEmpty || (val.length < 3)
                                ? "Please enter new password"
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _updatePassword,
                  child: Text("Update Password"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String oldpass = _oldPassController.text;
    String newpass = _newPassController.text;
    String userid = widget.userdata.userid!;

    var url =
        Uri.parse("${ServerConfig.server}/talktongue/php/update_password.php");
    var response = await http.post(url, body: {
      'userid': userid,
      'oldpass': oldpass,
      'newpass': newpass,
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password updated successfully"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to update password: ${jsonResponse['data']}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating password")),
      );
    }
  }
}
