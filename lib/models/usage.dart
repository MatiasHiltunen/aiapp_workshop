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