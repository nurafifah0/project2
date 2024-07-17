class User {
  String? userid;
  String? username;
  String? useremail;
  String? userpassword;
  String? userdatereg;
  String? latestMessage;
  bool isSelected = false;

  User({
    this.userid,
    this.username,
    this.useremail,
    this.userpassword,
    this.userdatereg,
    this.latestMessage,
    this.isSelected = false,
  });

  User.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['username'];
    useremail = json['useremail'];
    userpassword = json['userpassword'];
    userdatereg = json['userdatereg'];
    latestMessage = json['latestmessage'];
    isSelected = false; // Default value
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['username'] = username;
    data['useremail'] = useremail;
    data['userpassword'] = userpassword;
    data['userdatereg'] = userdatereg;
    data['latestmessage'] = latestMessage;
    return data;
  }
}
