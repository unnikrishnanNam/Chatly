import 'dart:io';

import 'package:chatly/api/apis.dart';
import 'package:chatly/helper/dialogs.dart';
import 'package:chatly/pages/home.dart';
import 'package:chatly/styles/style_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chatly/widget/my_button.dart';
import 'package:chatly/widget/my_checkbox.dart';
import 'package:chatly/widget/my_icon_button.dart';
import 'package:chatly/widget/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Dialogs.showSnackbar(context, 'Something went wrong', Colors.red,
          Icons.warning_amber_rounded);
      print('Sign in went wrong: $e');
    }
    return null;
  }

  _handleGoogleBtnClick() {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if (user != null) {
        if ((await APIs.userExists())) {
          APIs.getSelfInfo().then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
            );
          });
        } else {
          APIs.createUser().then((value) {
            APIs.getSelfInfo().then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomePage(),
                ),
              );
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const Text(
                    'Login',
                    style: ThemeText.HeadingText,
                  ),
                  const MyTextField(
                    text: 'Email',
                    hintText: 'Enter your Email',
                  ),
                  const MyTextField(
                    text: 'Passcode',
                    hintText: 'Enter your Passcode',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyCheckBox(),
                        GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Forgot passcode?',
                              style: ThemeText.SmallText,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Or',
                            style: ThemeText.SmallText,
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MyIconButton(
                      onPress: _handleGoogleBtnClick,
                      imagePath: 'lib/assets/images/google.png',
                      text: 'login using Google'),
                  const MyIconButton(
                      imagePath: 'lib/assets/images/apple.png',
                      text: 'login using Apple ID'),
                  MyButton(onPress: () {}, text: 'Login')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
