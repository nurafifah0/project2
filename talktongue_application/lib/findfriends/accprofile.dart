import 'package:flutter/material.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/user.dart';

class AccProfile extends StatefulWidget {
  const AccProfile({
    super.key,
    required this.userdata,
  });
  final User userdata;

  @override
  State<AccProfile> createState() => _AccProfileState();
}

class _AccProfileState extends State<AccProfile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
