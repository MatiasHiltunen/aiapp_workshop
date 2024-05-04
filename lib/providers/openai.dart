import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/gpt_answer.dart';
import '../models/open_ai_model.dart';
import 'package:http/http.dart' as http;

class OpenAIProvider extends ChangeNotifier {
  List<String> messages = [];

  void createMessage(String message) {
    messages.add(message);

    notifyListeners();
  }

  Future<GPTAnswer> askChatGPT(OpenAIModel data) async {
    final headers = {
      HttpHeaders.authorizationHeader:
          'Bearer <API_KEY_HERE>',
      'Content-Type': 'application/json; charset=UTF-8'
    };

    final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: headers,
        body: jsonEncode(data.toJson()));

    final responseData = jsonDecode(response.body);
    final answer = GPTAnswer.fromJson(responseData);

    return answer;
  }
}
