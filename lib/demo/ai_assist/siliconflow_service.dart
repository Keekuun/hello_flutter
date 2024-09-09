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
}
