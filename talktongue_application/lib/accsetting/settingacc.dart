import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/mydrawer.dart';
import 'package:talktongue_application/shared/serverconfig.dart';
import 'package:talktongue_application/view/login.dart';
import 'package:talktongue_application/view/signup.dart';
import 'package:talktongue_application/view/splashscreen.dart';
import 'package:http/http.dart' as http;
//import 'package:talktongue_application/view/main.dart';

//void main() => runApp(const AccountSetting());

class AccountSetting extends StatefulWidget {
  const AccountSetting(
      {super.key,
      required this.userdata,
      required this.user,
      required this.post});
  final User userdata;
  final User user;
  final Post post;

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  late double screenWidth, screenHeight;
  File? _image;
  final df = DateFormat('dd/MM/yyyy');
  var val = 50;

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
              //CircleAvatar(backgroundImage: AssetImage('')),
              Text(
                "My Account",
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
        drawer: MyDrawer(
          page: 'setting',
          userdata: widget.userdata,
          post: widget.post,
        ),
        backgroundColor: const Color.fromARGB(197, 233, 179, 207),
        body: Center(
          child: Column(children: [
            Container(
              height: screenHeight * 0.25,
              padding: const EdgeInsets.all(4),
              child: Card(
                  child: Row(children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.4,
                  child: GestureDetector(
                    onTap: () {
                      showSelectionDialog();
                    },
                    child: Container(
                      height: screenHeight * 0.3,
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: _image == null
                                  ? NetworkImage(
                                      // fit: BoxFit.fill,
                                      "${ServerConfig.server}/talktongue/assets/profile/${widget.userdata.userid}.png")
                                  : FileImage(_image!) as ImageProvider)),
                    ),
                  ),
                ),
                Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Text(
                          widget.userdata.username.toString().toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        const Divider(
                          color: Color.fromARGB(255, 34, 50, 58),
                        ),
                        Text(
                          widget.userdata.useremail.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ))
              ])),
            ),
            Container(
              height: screenHeight * 0.035,
              alignment: Alignment.center,
              color: Colors.purple,
              width: screenWidth,
              child: const Text("UPDATE ACCOUNT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            // const Divider(
            //   color: Colors.blueGrey,
            // ),
            Expanded(
                child: ListView(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    shrinkWrap: true,
                    children: [
                  MaterialButton(
                    onPressed: () {},
                    child: const Text("UPDATE NAME"),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: const Text("UPDATE PASSWORD"),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const SignUpPage()));
                    },
                    child: const Text("NEW REGISTRATION"),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const LoginPage()));
                    },
                    child: const Text("LOGIN"),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const SplashScreen1()));
                    },
                    child: const Text("LOGOUT"),
                  ),
                ])),
          ]),
        ));
  }

  void showSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: const Text(
              "Select from",
              style: TextStyle(),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth / 4, screenHeight / 8)),
                  child: const Text('Gallery'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    _selectfromGallery(),
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth / 4, screenHeight / 8)),
                  child: const Text('Camera'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    _selectFromCamera(),
                  },
                ),
              ],
            ));
      },
    );
  }

  Future<void> _selectfromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      cropImage();
    } else {}
  }

  Future<void> _selectFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);

      cropImage();
    } else {}
  }

  Future<void> cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio4x3,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Please Crop Your Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      File imageFile = File(croppedFile.path);
      _image = imageFile;
      _updateProfileImage(_image);
      setState(() {});
    }
  }

  void _updateProfileImage(image) {
    String imagestr = base64Encode(_image!.readAsBytesSync());
    http.post(
        Uri.parse("${ServerConfig.server}/talktongue/php/update_profile.php"),
        body: {
          "userid": widget.userdata.userid.toString(),
          "image": imagestr
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) => AccountSetting(
                        userdata: widget.userdata,
                        user: widget.userdata,
                        post: widget.post,
                      )));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }
}
