import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String text;
  final String? hintText;
  final String? initialText;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController? textController;
  final Function(String?)? onSave;
  final Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.text,
    this.hintText,
    this.textController,
    this.initialText,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.onSave,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(color: Color(0xFF606060), fontSize: 16),
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF272727),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextFormField(
              initialValue: initialText,
              obscureText: obscureText,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              cursorWidth: 2,
              cursorColor: const Color(0xFFF66052),
              cursorRadius: const Radius.circular(4),
              keyboardType: textInputType,
              controller: textController,
              onSaved: (newValue) => onSave!(newValue),
              validator: (newValue) => validator!(newValue),
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle:
                      const TextStyle(color: Color(0xFF606060), fontSize: 16),
                  border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
