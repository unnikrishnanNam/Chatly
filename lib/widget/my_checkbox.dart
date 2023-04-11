import 'package:chatly/styles/style_utils.dart';
import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  late bool? _value = true;
  MyCheckBox({super.key});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          onChanged: (bool? value) {
            setState(() {
              widget._value = value;
            });
          },
          value: widget._value,
          activeColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          side: MaterialStateBorderSide.resolveWith(
            (states) => BorderSide(width: 2.0, color: Colors.red),
          ),
        ),
        Text(
          'Remeber Me?',
          style: ThemeText.SmallText,
        )
      ],
    );
  }
}
