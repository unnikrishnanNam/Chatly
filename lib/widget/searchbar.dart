import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final Function(String)? onChange;
  const SearchBox({
    super.key,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextField(
        style: TextStyle(color: Colors.grey.shade100),
        cursorColor: const Color(0xFFF66052),
        cursorRadius: const Radius.circular(4),
        onChanged: (value) => onChange!(value),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade700,
              size: 20,
            ),
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey.shade700)),
      ),
    );
  }
}
