import 'dart:async';

import 'package:flutter/material.dart';

import 'message_item.dart';

class StreamMessageItem extends StatefulWidget {
  final Stream<String> stream;
  final Function(String)? onListen;
  final Function(String)? onEnd;

  const StreamMessageItem(
      {super.key, required this.stream, this.onListen, this.onEnd});

  @override
  State<StreamMessageItem> createState() => _StreamMessageItemState();
}

class _StreamMessageItemState extends State<StreamMessageItem> {
  int len = 0;
  String _message = '';

  @override
  void initState() {
    super.initState();
    widget.stream.listen((value) async {
      _message += value;
      widget.onListen?.call(value);
      setState(() {});
    }, onDone: () {
      widget.onEnd?.call(_message);
    }, onError: (error) {
      print('Error: $error');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MessageItem(
      isAiMessage: true,
      message: _message,
    );
  }
}
