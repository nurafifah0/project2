import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/setting.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/mydrawer.dart';
import 'package:talktongue_application/shared/serverconfig.dart';
/* import 'package:talktongue_application/view/login.dart';
import 'package:talktongue_application/view/signup.dart';
import 'package:talktongue_application/view/splashscreen.dart'; */
import 'package:http/http.dart' as http;
//import 'package:talktongue_application/view/main.dart';

//void main() => runApp(const AccountSetting());

class AccountSetting extends StatefulWidget {
  const AccountSetting(
      {super.key,
      required this.userdata,
      // required this.user,
      required this.post,
      required this.setting});
  final User userdata;
  //final User user;
  final Post post;
  final Setting setting;

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  late double screenWidth, screenHeight;
  File? _image;
  final df = DateFormat('dd/MM/yyyy');
  var val = 50;

  String dropdownvalue1 = 'None';
  var types1 = [
    'None',
    'English',
    'Spanish',
    'Malay',
  ];

  String dropdownvalue2 = 'None';
  var types2 = [
    'None',
    'English',
    'Spanish',
    'Malay',
  ];

  String dropdownvalue3 = 'None';
  var types3 = [
    'None',
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  bool isDisable = false;
  //final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  // final TextEditingController _oldpasswordController = TextEditingController();
  // final TextEditingController _newpasswordController = TextEditingController();
  // final TextEditingController _newaddressController = TextEditingController();
  Random random = Random();

  @override
  void initState() {
    super.initState();
    if (widget.userdata.userid == "0") {
      isDisable = true;
    } else {
      isDisable = false;
    }

    _ageController.text = widget.setting.userage.toString();
    dropdownvalue1 = widget.setting.usernativelang.toString();
    dropdownvalue2 = widget.setting.userlearninglang.toString();
    dropdownvalue3 = widget.setting.userfluency.toString();
    //_phoneController.text = widget.userdata.userphone.toString();
    //_newaddressController.text = widget.userdata.useraddress.toString();
  }

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
          setting: widget.setting,
        ),
        backgroundColor: const Color.fromARGB(197, 233, 179, 207),
        body: Center(
          child: Column(children: [
            Container(
              //height: screenHeight * 0.25,
              padding: const EdgeInsets.all(4),
              child: Column(children: [
                GestureDetector(
                  onTap: () {
                    showSelectionDialog();
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _image == null
                                ? NetworkImage(
                                    // fit: BoxFit.fill,
                                    "${ServerConfig.server}/talktongue/assets/profile/${widget.userdata.userid}.png")
                                : FileImage(_image!) as ImageProvider)),
                  ),
                ),
              ]),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text(widget.userdata.username.toString().toUpperCase(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
              ],
            ),
            /* const Text("Email : ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center), */
            const SizedBox(
              height: 30,
            ),
            Card(
              color: const Color.fromARGB(255, 146, 169, 181),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Text("Age : ",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      Text(widget.setting.userage.toString(),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      SizedBox(
                        width: 30,
                      ),
                      IconButton(
                          onPressed: () {
                            _updateAgeDialog();
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Text("Native Language : ",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      Text(widget.setting.usernativelang.toString(),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      SizedBox(
                        width: 30,
                      ),
                      IconButton(
                          onPressed: () {
                            _updateNativeLangDialog();
                          },
                          icon: const Icon(Icons.edit)),
                      /* Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.new_label, color: Colors.grey),
                              Container(
                                  margin: const EdgeInsets.all(8),
                                  height: 50,
                                  width: screenWidth * 0.2,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0))),
                                  child: DropdownButton(
                                    value: dropdownvalue1,
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: types1.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      dropdownvalue1 = newValue!;

                                      setState(() {});
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ), */
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Text("Learning Language : ",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      Text(widget.setting.userlearninglang.toString(),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      SizedBox(
                        width: 30,
                      ),
                      IconButton(
                          onPressed: () {
                            _updateLearningLangDialog();
                          },
                          icon: const Icon(Icons.edit))
                      /* Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.new_label, color: Colors.grey),
                              Container(
                                  margin: const EdgeInsets.all(8),
                                  height: 50,
                                  width: screenWidth * 0.2,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0))),
                                  child: DropdownButton(
                                    value: dropdownvalue2,
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: types2.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      dropdownvalue2 = newValue!;

                                      setState(() {});
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ), */
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Text("Fluency Language : ",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      Text(widget.setting.userfluency.toString(),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      SizedBox(
                        width: 30,
                      ),
                      IconButton(
                          onPressed: () {
                            _updateFluencyLangDialog();
                          },
                          icon: const Icon(Icons.edit))
                      /*  Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.new_label, color: Colors.grey),
                              Container(
                                  margin: const EdgeInsets.all(8),
                                  height: 50,
                                  width: screenWidth * 0.2,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0))),
                                  child: DropdownButton(
                                    value: dropdownvalue3,
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: types3.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      dropdownvalue3 = newValue!;

                                      setState(() {});
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ), */
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  //  _update;
                },
                child: Text(
                  "save changes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Text("change email and password ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const Text(""),
                const SizedBox(
                  width: 50,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                  alignment: Alignment.centerRight,
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Text("Account Deletion ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const Text(""),
                const SizedBox(
                  width: 140,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                  alignment: Alignment.centerRight,
                )
              ],
            ),
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
                        // user: widget.userdata,
                        post: widget.post, setting: widget.setting,
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

  void _updateAgeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change age?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _ageController,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                String newage = _ageController.text;
                _updateAge(newage);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateAge(String newage) {
    String newage = _ageController.text;
    http.post(Uri.parse("${ServerConfig.server}/talktongue/php/age.php"),
        body: {
          "userid": widget.userdata.userid.toString(),
          "newage": newage,
          // "newname": newname,
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();

          setState(() {
            widget.setting.userage = newage;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }

  void _updateNativeLangDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change native language?",
            style: TextStyle(),
          ),
          content: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.new_label, color: Colors.grey),
                  Container(
                      margin: const EdgeInsets.all(8),
                      height: 50,
                      width: screenWidth * 0.2,
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0))),
                      child: DropdownButton(
                        value: dropdownvalue1,
                        underline: const SizedBox(),
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: types1.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          dropdownvalue1 = newValue!;

                          setState(() {});
                        },
                      )),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                String status1 = dropdownvalue1;
                _updatenative(status1);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updatenative(String status1) {
    String status1 = dropdownvalue1;
    http.post(
        Uri.parse("${ServerConfig.server}/talktongue/php/update_profile.php"),
        body: {
          "userid": widget.userdata.userid.toString(),
          "status1": status1,
          // "newname": newname,
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();

          setState(() {
            widget.setting.usernativelang = status1;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }

  void _updateLearningLangDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Learning Language?",
            style: TextStyle(),
          ),
          content: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.new_label, color: Colors.grey),
                  Container(
                      margin: const EdgeInsets.all(8),
                      height: 50,
                      width: screenWidth * 0.2,
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0))),
                      child: DropdownButton(
                        value: dropdownvalue2,
                        underline: const SizedBox(),
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: types2.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          dropdownvalue2 = newValue!;

                          setState(() {});
                        },
                      )),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                String value2 = dropdownvalue2;
                _updatelearningLang(value2);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updatelearningLang(String value2) {
    String value2 = dropdownvalue2;
    http.post(
        Uri.parse("${ServerConfig.server}/talktongue/php/update_profile.php"),
        body: {
          "userid": widget.userdata.userid.toString(),
          "status2": value2,
          // "newname": newname,
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();

          setState(() {
            widget.setting.userlearninglang = value2;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }

  void _updateFluencyLangDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Fluency?",
            style: TextStyle(),
          ),
          content: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.new_label, color: Colors.grey),
                  Container(
                      margin: const EdgeInsets.all(8),
                      height: 50,
                      width: screenWidth * 0.3,
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0))),
                      child: DropdownButton(
                        value: dropdownvalue3,
                        underline: const SizedBox(),
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: types3.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          dropdownvalue3 = newValue!;

                          setState(() {});
                        },
                      )),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                String value3 = dropdownvalue3;
                _updateFluency(value3);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateFluency(value3) {
    String value3 = dropdownvalue3;
    http.post(
        Uri.parse("${ServerConfig.server}/talktongue/php/update_profile.php"),
        body: {
          "userid": widget.userdata.userid.toString(),
          "status3": value3,
          // "newname": newname,
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();

          setState(() {
            //widget.userdata.username = newname;
          });
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
