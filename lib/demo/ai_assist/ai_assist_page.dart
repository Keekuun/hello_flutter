import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hello_flutter/demo/ai_assist/siliconflow_service.dart';
import 'package:hello_flutter/demo/ai_assist/voice_action.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'message_item.dart';

class AiAssistPage extends StatefulWidget {
  const AiAssistPage({super.key});

  @override
  State<AiAssistPage> createState() => _AiAssistPageState();
}

class _AiAssistPageState extends State<AiAssistPage> {
  List<Widget> messages = [];
  final ScrollController _scrollController = ScrollController();

  final flutterTts = FlutterTts();

  final speechToText = SpeechToText();
  String lastWords = '';

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
  }

  Future<void> stopListening() async {
    await speechToText.stop();
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    messages.add(MessageItem(
      isAiMessage: false,
      message: result.recognizedWords,
    ));

    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 80,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
    );
  }

  void _handleTextInput(String prompt) async {
    setState(() {
      messages.add(MessageItem(
        isAiMessage: false,
        message: prompt,
      ));
    });
    _scrollToBottom();
    String response = await SiliconflowAIService().chatMessage(prompt);
    await systemSpeak(response);
    setState(() {
      messages.add(MessageItem(
        isAiMessage: true,
        message: response,
      ));
    });

    _scrollToBottom();
  }

  void _handleVoiceInput(String content, int duration) async {
    print('handleVoiceInput: $content, $duration');
    await stopListening();
  }

  @override
  void initState() {
    super.initState();

    initSpeechToText();
    initTextToSpeech();

    messages.add(const MessageItem(
        isAiMessage: true,
        message: '你好，我是智能AI，你可以向我提问任何问题，例如：\n'
            '1. 你知道 Flutter 是什么吗?\n'
            '2. 你知道 Flutter 的作者是谁吗?'));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    flutterTts.stop();
    super.dispose();
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
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 60),
            child: Column(children: messages),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          FloatingActionButton(
            heroTag: 'text_input',
            tooltip: '文本输入',
            backgroundColor: Colors.blueAccent,
            onPressed: () {
              setState(() {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 16.0,
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                              )),
                          child: TextField(
                            decoration: const InputDecoration(
                                hintText: '请输入问题', border: InputBorder.none),
                            autofocus: true,
                            // 监听 enter
                            onEditingComplete: () {
                              Navigator.pop(context);
                              _scrollToBottom();
                            },
                            onSubmitted: _handleTextInput,
                          ),
                        ));
              });
            },
            child: const Icon(
              Icons.text_fields_rounded,
              color: Colors.white,
            ),
          ),
          FloatingActionButton(
            heroTag: 'voice_input',
            tooltip: '语音输入',
            onPressed: () {},
            child: VoiceAction(
              onEnd: _handleVoiceInput,
              onStart: startListening,
            ),
          )
        ]),
      ),
    );
  }
}
