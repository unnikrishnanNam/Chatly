import 'dart:developer';

import 'package:chatly/api/apis.dart';
import 'package:chatly/helper/my_date_util.dart';
import 'package:chatly/models/message.dart';
import 'package:chatly/styles/style_utils.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  final Message message;
  const MessageCard({super.key, required this.message});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid != widget.message.fromId
        ? _redMessage()
        : _orangeMessage();
  }

  Widget _redMessage() {
    if (widget.message.readTime.isEmpty) {
      APIs.updateMessageReadStatus(widget.message);
      log('message read updated');
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Text(
              widget.message.message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Text(
            MyDateUtil.getFormattedTime(
                context: context, time: widget.message.sentTime),
            style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
          ),
        ),
      ],
    );
  }

  Widget _orangeMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            widget.message.readTime.isNotEmpty
                ? const Icon(
                    Icons.done_all_rounded,
                    color: Colors.amber,
                    size: 18,
                  )
                : const Icon(
                    Icons.done_all_rounded,
                    color: Colors.grey,
                    size: 18,
                  ),
            const SizedBox(
              width: 10,
            ),
            Text(
              MyDateUtil.getFormattedTime(
                  context: context, time: widget.message.sentTime),
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
          ],
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.primary,
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Text(
              widget.message.message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
