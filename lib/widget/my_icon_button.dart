import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final String imagePath;
  final Function()? onPress;
  final String text;
  const MyIconButton(
      {super.key, required this.imagePath, required this.text, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onPress,
        child: Ink(
          height: 56,
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xFF272727),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 60,
              ),
              Image.asset(
                imagePath,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  text,
                  style:
                      const TextStyle(color: Color(0xFF606060), fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
