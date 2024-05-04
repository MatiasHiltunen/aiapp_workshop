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