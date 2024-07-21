import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/serverconfig.dart';
import 'package:talktongue_application/view/login.dart';

class AccountDeletion extends StatefulWidget {
  // final String userid;
  final User userdata;

  const AccountDeletion(
      {super.key, /* required this.userid, */ required this.userdata});

  @override
  State<AccountDeletion> createState() => _AccountDeletionState();
}

class _AccountDeletionState extends State<AccountDeletion> {
  late double screenWidth, screenHeight;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Account Deletion",
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
          onRefresh: () async {},
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            height: screenHeight * 0.6,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 200),
                  Text(
                    "Are you sure you want to delete your account?",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  SizedBox(height: 60),
                  Center(
                      child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: _deleteAccount,
                        child: Text("Delete Account"),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _deleteAccount() async {
    // String userid = widget.userid;
    String userid = widget.userdata.userid.toString();

    var url =
        Uri.parse("${ServerConfig.server}/talktongue/php/delete_account.php");
    var response = await http.post(url, body: {
      'userid': userid,
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 'success') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account deleted successfully"),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate to another screen if needed
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (content) => const LoginPage(

                    //userid: '',
                    )));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Failed to delete account: ${jsonResponse['data']}")),
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error deleting account")),
      );
    }
  }
}
