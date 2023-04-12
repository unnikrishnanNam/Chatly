import 'package:chatly/styles/style_utils.dart';
import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool? _value = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          onChanged: (bool? value) {
            setState(() {
              _value = value;
            });
          },
          value: _value,
          activeColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          side: MaterialStateBorderSide.resolveWith(
            (states) => const BorderSide(width: 2.0, color: AppColors.primary),
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
