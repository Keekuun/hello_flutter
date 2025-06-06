import 'dart:convert';

import 'package:hello_flutter/demo/ai_assist/secrets.dart';
import 'package:http/http.dart' as http;

// https://docs.siliconflow.cn/reference/chat-completions-3
class SiliconflowAIService {
  final List<Map<String, String>> messages = [];

  Future<String> chatMessage(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.siliconflow.cn/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $siliconflowAPIKey',
        },
        body: jsonEncode({
          "model": "deepseek-ai/DeepSeek-V2-Chat",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Stream<String> chatMessageStream(String prompt) async* {
    messages.add({
      'role': 'user',
      'content': prompt,
    });

    try {
      final request = http.Request(
          'POST', Uri.parse('https://api.siliconflow.cn/v1/chat/completions'));
      request.headers.addAll({
        'accept': 'text/event-stream',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $siliconflowAPIKey',
      });
      request.body = jsonEncode({
        "model": "deepseek-ai/DeepSeek-V2-Chat",
        "messages": messages,
        "stream": true
      });

      var streamedResponse = await request.send();

      String jsonStr = '';
      String res = '';
      await for (var line in streamedResponse.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())) {
        try {
          res = jsonDecode(jsonStr.replaceAll('data: ', ''))['choices'][0]
              ['delta']['content'];
          jsonStr = '';
          for (int i = 0; i < res.length; i++) {
            await Future.delayed(const Duration(milliseconds: 60));
            yield res[i];
          }
        } catch (e) {
          jsonStr += line;
        }

        if (jsonStr == '[DONE]') {
          break;
        }
      }
    } catch (e) {
      yield 'Error: $e';
    }
  }
}
