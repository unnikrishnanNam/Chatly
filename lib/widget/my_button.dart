import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final Function onPress;
  final String text;
  const MyButton({super.key, required this.onPress, required this.text});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => setState(() {
          widget.onPress();
        }),
        child: Ink(
          height: 56,
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFFF66052), Color(0xFFDE3178)]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
