import 'package:flutter/material.dart';
import 'package:hello_flutter/demo/todo_list/page.dart';
import 'package:hello_flutter/demo/voice/speech_to_text.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListItem(
          title: 'Todo list',
          subtitle: 'Todo list demo',
          icon: Icons.list,
          target: TodoListDemo(),
        ),
        ListItem(
          title: 'Speech to text',
          subtitle: 'Speech to text demo',
          icon: Icons.voice_chat_rounded,
          target: SpeechToText(),
        ),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget target;

  const ListItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.target});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return target;
        }));
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.black12),
        margin: const EdgeInsets.all(8),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
        ),
      ),
    );
  }
}
