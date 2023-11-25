import 'package:chatly/styles/style_utils.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static void showSnackbar(
      BuildContext context, String text, Color color, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Container(
        height: 50,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              Text(text),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
