class Setting {
  String? userid;
  String? userage;
  String? usernativelang;
  String? userlearninglang;
  String? userfluency;

  Setting({
    this.userid,
    this.userage,
    this.usernativelang,
    this.userlearninglang,
    this.userfluency,
  });

  Setting.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    userage = json['userage'];
    usernativelang = json['usernativelang'];
    userlearninglang = json['userlearninglang'];
    userfluency = json['userfluency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['userage'] = userage;
    data['usernativelang'] = usernativelang;
    data['userlearninglang'] = userlearninglang;
    data['userfluency'] = userfluency;

    return data;
  }
}
