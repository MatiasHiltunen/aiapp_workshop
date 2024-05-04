import 'message.dart';

class Choices {
  String? finishReason;
  int? index;
  Message? message;
  Null logprobs;
 
  Choices({this.finishReason, this.index, this.message, this.logprobs});
 
  Choices.fromJson(Map<String, dynamic> json) {
    finishReason = json['finish_reason'];
    index = json['index'];
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
    logprobs = json['logprobs'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['finish_reason'] = finishReason;
    data['index'] = index;
    if (message != null) {
      data['message'] = message!.toJson();
    }
    data['logprobs'] = logprobs;
    return data;
  }
}