import 'dart:convert';

import 'package:chatly/api/apis.dart';
import 'package:chatly/helper/dialogs.dart';
import 'package:chatly/models/chat_user.dart';
import 'package:chatly/pages/login.dart';
import 'package:chatly/pages/profile.dart';
import 'package:chatly/widget/chatee_list_tile.dart';
import 'package:chatly/widget/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widget/my_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChatUser> list = [];
  final List<ChatUser> _searchList = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  _handleLogout() async {
    await APIs.auth.signOut();
    await GoogleSignIn().signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (builder) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          MyAppBar(
            handleLogout: _handleLogout,
            handleProfile: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ProfilePage(user: APIs.me)));
            },
          ),
          const SizedBox(
            height: 20,
          ),
          SearchBox(
            onChange: (val) {
              _searchList.clear();
              for (var i in list) {
                if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                    i.email.toLowerCase().contains(val.toLowerCase())) {
                  _searchList.add(i);
                }

                if (val.isNotEmpty) {
                  setState(() {
                    _isSearching = true;
                    _searchList;
                  });
                } else {
                  setState(() {
                    _isSearching = false;
                  });
                }
              }
            },
          ),
          Expanded(
            child: StreamBuilder(
                stream: APIs.getAllUsers(),
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
                      list = data
                              ?.map((e) => ChatUser.fromJson(e.data()))
                              .toList() ??
                          [];

                      if (list.isNotEmpty) {
                        return ListView.builder(
                            padding: const EdgeInsets.only(top: 10),
                            itemCount:
                                _isSearching ? _searchList.length : list.length,
                            itemBuilder: (context, index) {
                              return ChateeListTile(
                                  user: _isSearching
                                      ? _searchList[index]
                                      : list[index]);
                            });
                      } else {
                        return Center(
                          child: Text(
                            'No chats found',
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 21),
                          ),
                        );
                      }
                  }
                }),
          )
        ],
      ),
    );
  }
}
