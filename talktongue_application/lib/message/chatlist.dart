import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:talktongue_application/message/chatpage.dart';
import 'package:talktongue_application/message/contactlist.dart';
import 'package:talktongue_application/models/post.dart';
import 'package:talktongue_application/models/user.dart';
import 'package:talktongue_application/shared/mydrawer.dart';
import 'package:talktongue_application/shared/serverconfig.dart';

class ChatListPage extends StatefulWidget {
  final User currentUser;
  final Post post;

  const ChatListPage({super.key, required this.currentUser, required this.post});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<User> chatUsers = [];
  List<User> selectedChats = [];
  bool isSelecting = false;

  @override
  void initState() {
    super.initState();
    loadChatUsers();
  }

  void loadChatUsers() async {
    final response = await http.get(Uri.parse(
        "${ServerConfig.server}/talktongue/php/load_chat_users2.php?userid=${widget.currentUser.userid}"));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['main_response']['status'] == 'success') {
        setState(() {
          chatUsers = (data['main_response']['data']['users'] as List)
              .map((user) => User.fromJson(user))
              .where((user) => user.latestMessage != null)
              .toList();
        });
      }
    }
  }

  void deleteSelectedChats() async {
    for (var user in selectedChats) {
      final response = await http.post(
        Uri.parse("${ServerConfig.server}/talktongue/php/delete_chat.php"),
        body: {
          'userid': widget.currentUser.userid,
          'chatid': user.userid,
        },
      );
      if (response.statusCode != 200) {
        print('Failed to delete chat with user ${user.userid}');
      }
    }
    setState(() {
      chatUsers.removeWhere((user) => user.isSelected);
      selectedChats.clear();
      isSelecting = false;
    });
  }

  void pinSelectedChats() {
    setState(() {
      List<User> pinnedChats = selectedChats.take(3).toList();
      chatUsers.removeWhere((user) => pinnedChats.contains(user));
      chatUsers.insertAll(0, pinnedChats);
      selectedChats.clear();
      isSelecting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme:
          ThemeData(colorSchemeSeed: const Color.fromARGB(197, 233, 179, 207)),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              isSelecting ? '${selectedChats.length} selected' : 'Chat List'),
          backgroundColor: Colors.transparent,
          titleTextStyle: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          actions: isSelecting
              ? [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: deleteSelectedChats,
                  ),
                  IconButton(
                    icon: const Icon(Icons.push_pin),
                    onPressed: pinSelectedChats,
                  ),
                ]
              : [],
        ),
        drawer: MyDrawer(
          page: "chat",
          userdata: widget.currentUser,
          post: widget.post,
        ),
        backgroundColor: const Color.fromARGB(197, 233, 179, 207),
        body: RefreshIndicator(
          onRefresh: () async {
            loadChatUsers();
          },
          child: ListView.separated(
            itemCount: chatUsers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  setState(() {
                    chatUsers[index].isSelected = !chatUsers[index].isSelected;
                    if (chatUsers[index].isSelected) {
                      selectedChats.add(chatUsers[index]);
                    } else {
                      selectedChats.remove(chatUsers[index]);
                    }
                    isSelecting = selectedChats.isNotEmpty;
                  });
                },
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: chatUsers[index].userid != null
                            ? NetworkImage(
                                "${ServerConfig.server}/talktongue/assets/profile/${chatUsers[index].userid}.png",
                              )
                            : const AssetImage("assets/images/profile.jpg")
                                as ImageProvider,
                        fit: BoxFit.cover,
                        onError: (error, stackTrace) {
                          print("Error loading image: $error");
                        },
                      ),
                    ),
                  ),
                  title: Text(
                      truncateString(chatUsers[index].username ?? "Unknown")),
                  subtitle:
                      Text(chatUsers[index].latestMessage ?? "No messages yet"),
                  selected: chatUsers[index].isSelected,
                  onTap: () {
                    if (isSelecting) {
                      setState(() {
                        chatUsers[index].isSelected =
                            !chatUsers[index].isSelected;
                        if (chatUsers[index].isSelected) {
                          selectedChats.add(chatUsers[index]);
                        } else {
                          selectedChats.remove(chatUsers[index]);
                        }
                        isSelecting = selectedChats.isNotEmpty;
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            currentUser: widget.currentUser,
                            targetUser: chatUsers[index],
                          ),
                        ),
                      );
                    }
                  },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                color: Colors.black12,
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (content) => ContactListPage(
                          currentUser: widget.currentUser,
                          post: widget.post,
                        ))).then((_) => loadChatUsers());
          },
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
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
