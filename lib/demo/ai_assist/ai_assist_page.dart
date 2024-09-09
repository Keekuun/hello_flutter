import 'package:flutter/material.dart';

import 'message_item.dart';

class AiAssistPage extends StatefulWidget {
  const AiAssistPage({super.key});

  @override
  State<AiAssistPage> createState() => _AiAssistPageState();
}

class _AiAssistPageState extends State<AiAssistPage> {
  List<MessageItem> messages = [];

  @override
  void initState() {
    super.initState();

    messages.add(const MessageItem(
        isAiMessage: true,
        message: '你好，我是智能AI，你可以向我提问任何问题，例如：\n'
            '1. 你知道 Flutter 是什么吗？\n'
            '2. 你知道 Flutter 是什么吗？'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '智能AI 助手',
          style: TextStyle(
              color: Colors.redAccent,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: messages),
      )),
      floatingActionButton: FloatingActionButton(
        heroTag: 'ai_assist_page',
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
