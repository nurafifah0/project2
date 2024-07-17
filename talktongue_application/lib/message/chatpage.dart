import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:talktongue_application/models/message.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/serverconfig.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final User currentUser;
  final User targetUser;

  const ChatPage(
      {super.key, required this.currentUser, required this.targetUser});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [];
  Set<Message> selectedMessages = {};
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  void loadMessages() async {
    final response = await http.get(Uri.parse(
        "${ServerConfig.server}/talktongue/php/load_messages.php?sender_id=${widget.currentUser.userid}&receiver_id=${widget.targetUser.userid}"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        setState(() {
          messages = (data['data']['messages'] as List)
              .map((message) => Message.fromJson(message))
              .toList();
        });
      }
    }
  }

  void sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;
    final response = await http.post(
      Uri.parse("${ServerConfig.server}/talktongue/php/send_message.php"),
      body: {
        'sender_id': widget.currentUser.userid,
        'receiver_id': widget.targetUser.userid,
        'message': _messageController.text,
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        _messageController.clear();
        loadMessages();
      }
    }
  }

  void deleteMessageForUser(Message message) async {
    final response = await http.post(
      Uri.parse(
          "${ServerConfig.server}/talktongue/php/delete_message_for_user.php"),
      body: {
        'message_id': message.messageId.toString(),
        'user_id': widget.currentUser.userid,
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        setState(() {
          messages.remove(message);
          selectedMessages.remove(message);
        });
      }
    }
  }

  void deleteMessages() {
    selectedMessages.forEach(deleteMessageForUser);
  }

  String formatTimestamp(String timestamp) {
    DateTime messageTime = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(messageTime);

    if (difference.inHours < 24) {
      return DateFormat('hh:mm a').format(messageTime);
    } else {
      return DateFormat('dd MMM yyyy, hh:mm a').format(messageTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with ${widget.targetUser.username}"),
        backgroundColor: Colors.transparent,
        actions: selectedMessages.isNotEmpty
            ? [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: deleteMessages,
                ),
              ]
            : null,
      ),
      backgroundColor: const Color.fromARGB(197, 233, 179, 207),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isCurrentUser =
                    messages[index].senderId == widget.currentUser.userid;
                bool isSelected = selectedMessages.contains(messages[index]);
                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      if (isSelected) {
                        selectedMessages.remove(messages[index]);
                      } else {
                        selectedMessages.add(messages[index]);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    child: Align(
                      alignment: isCurrentUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.red.withOpacity(0.5)
                              : isCurrentUser
                                  ? const Color.fromARGB(198, 133, 20, 127)
                                  : const Color.fromARGB(147, 238, 238, 238),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: isCurrentUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              messages[index].content.toString(),
                              style: TextStyle(
                                color:
                                    isCurrentUser ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              formatTimestamp(
                                  messages[index].timestamp.toString()),
                              style: TextStyle(
                                color: isCurrentUser
                                    ? Colors.white60
                                    : Colors.black54,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Enter your message",
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send,
                      color: _messageController.text.isNotEmpty
                          ? Colors.grey
                          : Colors.black),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
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
}
