import 'dart:async';
import 'dart:convert';
import 'dart:io';
 
import 'package:http/http.dart' as http;

final List<Messages> messageHistory = [
  Messages(content: 'Olen FrostBit-ohjelmistolaboratorion oma tekoäly, toimin asiantuntijan roolissa. FrostBit on Lapin Ammattikorkeakoulun ohjelmistolaboratorio ja osallistun myös opetukseen, puhun selvää suomenkieltä ja kerron välillä puujalkavitsejä. Vastaan kysymyksiin ammattimaisesti.', role: 'system')
];
 
void main(List<String> arguments) {
  conversation('Kuinka voin auttaa sinua tänään?');
}
 
void conversation(String msg ) async {
 
  print(msg);
 
  final input = stdin.readLineSync();
 
  final message = Messages(content: input, role: 'user');
 
  messageHistory.add(message);
 
  final model = OpenAIModel(
    model: 'gpt-3.5-turbo',
    messages: messageHistory,
  );
 
 
  askChatGPT(model).then((value) => {

   
 
    conversation(value.choices?.first.message?.content ?? 'no message here')
 
  });
 
}
 

 
class OpenAIModel {
  late final String model;
  List<Messages>? messages;
 
  OpenAIModel({required this.model, this.messages});
 
  OpenAIModel.fromJson(Map<String, dynamic> json, this.model) {
    model = json['model'] ?? 'gpt-3.5-turbo';
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
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
 
class Messages {
  String? role;
  String? content;
 
  Messages({this.role, this.content});
 
  Messages.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    content = json['content'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['content'] = content;
    return data;
  }
}
 
class GPTAnswer {
  List<Choices>? choices;
  int? created;
  String? id;
  String? model;
  String? object;
  Usage? usage;
 
  GPTAnswer(
      {this.choices,
      this.created,
      this.id,
      this.model,
      this.object,
      this.usage});
 
  GPTAnswer.fromJson(Map<String, dynamic> json) {
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(new Choices.fromJson(v));
      });
    }
    created = json['created'];
    id = json['id'];
    model = json['model'];
    object = json['object'];
    usage = json['usage'] != null ? new Usage.fromJson(json['usage']) : null;
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.choices != null) {
      data['choices'] = this.choices!.map((v) => v.toJson()).toList();
    }
    data['created'] = this.created;
    data['id'] = this.id;
    data['model'] = this.model;
    data['object'] = this.object;
    if (this.usage != null) {
      data['usage'] = this.usage!.toJson();
    }
    return data;
  }
}
 
class Choices {
  String? finishReason;
  int? index;
  Message? message;
  Null? logprobs;
 
  Choices({this.finishReason, this.index, this.message, this.logprobs});
 
  Choices.fromJson(Map<String, dynamic> json) {
    finishReason = json['finish_reason'];
    index = json['index'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
    logprobs = json['logprobs'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['finish_reason'] = this.finishReason;
    data['index'] = this.index;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    data['logprobs'] = this.logprobs;
    return data;
  }
}
 
class Message {
  String? content;
  String? role;
 
  Message({this.content, this.role});
 
  Message.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    role = json['role'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['role'] = this.role;
    return data;
  }
}
 
class Usage {
  int? completionTokens;
  int? promptTokens;
  int? totalTokens;
 
  Usage({this.completionTokens, this.promptTokens, this.totalTokens});
 
  Usage.fromJson(Map<String, dynamic> json) {
    completionTokens = json['completion_tokens'];
    promptTokens = json['prompt_tokens'];
    totalTokens = json['total_tokens'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['completion_tokens'] = this.completionTokens;
    data['prompt_tokens'] = this.promptTokens;
    data['total_tokens'] = this.totalTokens;
    return data;
  }
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