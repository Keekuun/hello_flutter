import 'package:flutter/material.dart';
import 'package:hello_flutter/demo/editor/html_editor/html_editor.dart';
import 'package:hello_flutter/demo/editor/quill_editor/quill_editor.dart';
import 'package:hello_flutter/demo/todo_list/page.dart';
import 'package:hello_flutter/demo/voice/speech_to_text.dart';
import 'package:hello_flutter/demo/voice/text_to_speech.dart';
import 'package:share_plus/share_plus.dart';

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
          icon: Icons.mic_rounded,
          target: SpeechToText(),
        ),
        ListItem(
          title: 'Text to speech',
          subtitle: 'Text to speech demo',
          icon: Icons.record_voice_over_rounded,
          target: TextToSpeech(),
        ),
        ListItem(
          title: 'Html editor',
          subtitle: 'Html editor demo',
          icon: Icons.html_outlined,
          target: HtmlEditor(),
        ),
        ListItem(
          title: 'Quill editor',
          subtitle: 'Quill editor demo',
          icon: Icons.edit_note,
          target: QuillEditorDemo(),
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

  void _handleShare(String title) {
    Share.share(title);
  }

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
          trailing: InkWell(
              onTap: () {
                _handleShare(this.title);
              },
              child: const Icon(Icons.share)
          ),
        ),
      ),
    );
  }
}
