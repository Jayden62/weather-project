class MessageResult {
  String? cod;
  String? message;

  MessageResult({this.cod, this.message});

  MessageResult.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod'] = this.cod;
    data['message'] = this.message;
    return data;
  }
}
