import 'dart:convert';
import 'dart:developer';

import 'package:chatly/models/chat_user.dart';
import 'package:chatly/models/message.dart';
import 'package:chatly/widget/chat_inputfield.dart';
import 'package:chatly/widget/chatee_app_bar.dart';
import 'package:flutter/material.dart';

import '../api/apis.dart';
import '../widget/message_card.dart';

class ChatPage extends StatefulWidget {
  final ChatUser user;
  const ChatPage({super.key, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> _list = [];

  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ChateeAppBar(
              user: widget.user,
              onTap: () => Navigator.pop(context),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: APIs.getAllMessages(widget.user),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        // log('data ${jsonEncode(data![0].data())}');
                        _list = data
                                ?.map((e) => Message.fromJson(e.data()))
                                .toList() ??
                            [];

                        if (_list.isNotEmpty) {
                          return ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: _list.length,
                              itemBuilder: (context, index) {
                                return MessageCard(
                                  message: _list[index],
                                );
                              });
                        } else {
                          return Center(
                            child: Text(
                              'Say Hi 👋 to ${widget.user.name}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 21),
                            ),
                          );
                        }
                    }
                  }),
            ),
            ChatInputField(
              controller: _textController,
              handleSend: () {
                if (_textController.text.isNotEmpty) {
                  APIs.sendMessage(widget.user, _textController.text);
                  _textController.clear();
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
