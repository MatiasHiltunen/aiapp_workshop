
import 'package:flutter/material.dart';

class OpenAIProvider extends ChangeNotifier {

  List<String> messages = [];

  void createMessage(String message){

    messages.add(message);

    notifyListeners();
  }
}