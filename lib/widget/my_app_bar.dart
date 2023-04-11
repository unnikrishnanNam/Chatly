import 'package:chatly/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/apis.dart';

class MyAppBar extends StatefulWidget {
  final GestureTapCallback handleLogout;
  final GestureTapCallback handleProfile;
  const MyAppBar({
    super.key,
    required this.handleLogout,
    required this.handleProfile,
  });

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: widget.handleLogout,
            child: Ink(
              child: const Icon(
                Icons.logout_rounded,
                size: 28,
              ),
            ),
          ),
          const Text(
            'Chats',
            style: TextStyle(fontSize: 32),
          ),
          GestureDetector(
            onTap: widget.handleProfile,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.transparent,
              foregroundImage: NetworkImage(APIs.me.image),
            ),
          )
        ],
      ),
    );
  }
}
