import 'dart:async';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToText extends StatefulWidget {
  const SpeechToText({super.key});

  @override
  State<SpeechToText> createState() => _SpeechToTextState();
}

class _SpeechToTextState extends State<SpeechToText> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';
  int _duration = 0;
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text(
          'Speech to Text',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: Colors.blue[200],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white60),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Text(
                      _text,
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey),
                    child: Text(
                      'Duration: $_duration seconds',
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onLongPress: () {
                    _startListening();
                  },
                  onLongPressEnd: (details) {
                    _stopListening();
                  },
                  child: Column(
                    children: [
                      Ink(
                          decoration: const ShapeDecoration(
                            color: Colors.grey,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            color: _isListening ? Colors.green : Colors.white,
                            icon: _isListening
                                ? const Icon(Icons.mic)
                                : const Icon(Icons.mic_off),
                            iconSize: 80,
                            onPressed: () {
                              _isListening
                                  ? _stopListening()
                                  : _startListening();
                            },
                          )),
                      const SizedBox(
                        height: 80,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: _isListening ? Colors.green : Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          _isListening
                              ? 'Listening...'
                              : 'Press and Hold to Speak',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        if (_speech.isListening) {
          _startTimer();
        } else {
          _stopTimer();
        }
      },
      onError: (errorNotification) {
        print('_speech.initialize error: $errorNotification');
      },
    );

    if (available) {
      setState(() {
        _isListening = true;
        _duration = 0; // Reset the duration when starting a new session
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
        },
      );
    }
  }

  void _stopListening() {
    setState(() {
      _isListening = false;
      _stopTimer();
      _speech.stop();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _duration++;
      });
    });
  }

  void _stopTimer() {
    if (_timer.isActive) {
      _timer.cancel(); // Stop the timer if it's active
    }
  }

  @override
  void dispose() {
    _stopTimer();
    _speech.stop(); // Stop the timer when the widget is disposed
    super.dispose();
  }
}
