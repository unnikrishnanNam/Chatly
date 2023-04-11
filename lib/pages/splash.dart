import 'package:chatly/api/apis.dart';
import 'package:chatly/pages/home.dart';
import 'package:chatly/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      if (APIs.auth.currentUser != null) {
        APIs.getSelfInfo().then((value) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomePage()));
        });
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 160,
              width: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                  colors: [Color(0xFFF66052), Color(0xFFDE3178)],
                ),
              ),
              child: Center(
                child: Container(
                  height: 150,
                  width: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.grey.shade900, Colors.grey.shade900],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'CHATLY',
                    style:
                        GoogleFonts.tourney(fontSize: 52, color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.grey.shade900, Colors.grey.shade900],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'The most secure and fastest chat app',
                style: TextStyle(
                    color: Colors.grey.shade300,
                    letterSpacing: 1.5,
                    fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
