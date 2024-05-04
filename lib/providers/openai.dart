import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/gpt_answer.dart';
import '../models/message.dart';
import '../models/open_ai_model.dart';
import 'package:http/http.dart' as http;

class OpenAIProvider extends ChangeNotifier {
  List<String> messages = [];
  List<Message> messageHistory = [
    Message(
        content:
            "I'm mario from Super Mario Bros",
        role: 'system')
  ];

  void createMessage(String msg) async {
    final message = Message(content: msg, role: 'user');

    messageHistory.add(message);
    notifyListeners();

    await conversation();
  }

  Future<void> conversation() async {
    try {

    final model = OpenAIModel(
      model: 'gpt-3.5-turbo',
      messages: messageHistory,
    );

    var result = await askChatGPT(model);

    messageHistory.add(result.choices?.first.message  ??
        Message(content: "no content", role: 'system'));

    notifyListeners();
    } catch (error){
      print(error);
    }
  }

  Future<GPTAnswer> askChatGPT(OpenAIModel data) async {
    final headers = {
      HttpHeaders.authorizationHeader:
          'Bearer <OPEN API KEY HERE>',
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
