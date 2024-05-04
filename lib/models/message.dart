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