import 'choices.dart';
import 'usage.dart';

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