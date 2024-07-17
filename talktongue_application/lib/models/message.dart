class Message {
  String? messageId;
  String? senderId;
  String? receiverId;
  String? content;
  String? timestamp;

  Message(
      {this.messageId,
      this.senderId,
      this.receiverId,
      this.content,
      this.timestamp});

  Message.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    content = json['content'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_id'] = messageId;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['content'] = content;
    data['timestamp'] = timestamp;
    return data;
  }
}
