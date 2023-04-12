import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  final TextEditingController? controller;
  final Function()? handleSend;
  const ChatInputField({super.key, this.controller, this.handleSend});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.emoji_emotions,
                    color: Color(0xFFF66052),
                  ),
                  onPressed: () {},
                ),
                Expanded(
                    child: TextField(
                  controller: widget.controller,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Type something ..'),
                )),
                IconButton(
                  icon: const Icon(
                    Icons.image_rounded,
                    color: Color(0xFFF66052),
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    color: Color(0xFFF66052),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        MaterialButton(
            onPressed: widget.handleSend,
            shape: const CircleBorder(),
            color: const Color(0xFFF66052),
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
            minWidth: 0,
            child: const Icon(
              Icons.send_rounded,
              color: Colors.white,
              size: 32,
            ))
      ],
    );
  }
}
