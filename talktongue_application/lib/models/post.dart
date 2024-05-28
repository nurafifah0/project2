class Post {
  String? postId;
  String? userId;
  String? username;
  String? postDeets;
  String? postDate;

  Post({this.postId, this.userId, this.username, this.postDeets, this.postDate});

  Post.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    userId = json['user_id'];
    username = json['user_name'];
    postDeets = json['post_deets'];
    postDate = json['post_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['user_id'] = userId;
    data['user_name'] = username;
    data['post_deets'] = postDeets;
    data['post_date'] = postDate;
    return data;
  }
}
