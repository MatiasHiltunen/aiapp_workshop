

import 'message.dart';

class OpenAIModel {
  late final String model;
  List<Message>? messages;
 
  OpenAIModel({required this.model, this.messages});
 
  OpenAIModel.fromJson(Map<String, dynamic> json, this.model) {
    model = json['model'] ?? 'gpt-3.5-turbo';
    if (json['messages'] != null) {
      messages = <Message>[];
      json['messages'].forEach((v) {
        messages!.add(Message.fromJson(v));
      });
    }
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model'] = model;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}