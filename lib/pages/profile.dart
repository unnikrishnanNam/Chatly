import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatly/helper/dialogs.dart';
import 'package:chatly/models/chat_user.dart';
import 'package:chatly/pages/home.dart';
import 'package:chatly/widget/my_button.dart';
import 'package:chatly/widget/my_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../api/apis.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  final ChatUser user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formkey = GlobalKey<FormState>();
  String? _image;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(false);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
        return false;
      },
      child: Form(
        key: _formkey,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            _image != null
                                ? Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Color(0xFFF66052),
                                          Color(0xFFDE3178)
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(85)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: Image.file(
                                        File(_image!),
                                        height: 160,
                                        width: 160,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Color(0xFFF66052),
                                          Color(0xFFDE3178)
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(85)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: CachedNetworkImage(
                                          width: 160,
                                          height: 160,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              const CircleAvatar(
                                                child: Icon(
                                                  CupertinoIcons.person,
                                                  size: 100,
                                                ),
                                              ),
                                          imageUrl: widget.user.image),
                                    ),
                                  ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: MaterialButton(
                                color: Colors.white,
                                shape: const CircleBorder(),
                                onPressed: () {
                                  _showBottomSheet();
                                },
                                child: const Icon(
                                  Icons.edit_rounded,
                                  color: Color(0xFFDE3178),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            widget.user.email,
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 18),
                          ),
                        ),
                        MyTextField(
                          text: 'Name',
                          initialText: widget.user.name,
                          onSave: (val) => APIs.me.name = val ?? '',
                          validator: (val) => val != null && val.isNotEmpty
                              ? null
                              : 'Field is required',
                        ),
                        MyTextField(
                          text: 'Bio',
                          initialText: widget.user.bio,
                          onSave: (val) => APIs.me.bio = val ?? '',
                          validator: (val) => val != null && val.isNotEmpty
                              ? null
                              : 'Field is required',
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        MyButton(
                            onPress: () {
                              if (_formkey.currentState!.validate()) {
                                _formkey.currentState!.save();
                                APIs.updateUserInfo().then((value) {
                                  Dialogs.showSnackbar(
                                      context,
                                      'Profile updated',
                                      Colors.greenAccent.shade700,
                                      Icons.done_rounded);
                                });
                              }
                            },
                            text: "Update profile")
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.red.shade400,
                label: const Text('Logout'),
                icon: const Icon(Icons.logout_outlined),
                onPressed: () async {
                  Dialogs.showProgressBar(context);
                  await APIs.auth.signOut().then((value) async {
                    await GoogleSignIn().signOut().then((value) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (builder) => const LoginPage()));
                    });
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (_) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    'Choose your profile picture',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              _image = image.path;
                            });
                            APIs.updateProfilPicture(File(_image!));
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        },
                        child: const Icon(
                          Icons.image,
                          size: 34,
                          color: Color(0xFFF66052),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.camera);
                          if (image != null) {
                            setState(() {
                              _image = image.path;
                            });
                            APIs.updateProfilPicture(File(_image!));
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        },
                        child: const Icon(
                          Icons.camera,
                          size: 34,
                          color: Color(0xFFDE3178),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
