class token_model {
  String? status;
  int? id;
  String? token;
  String? type;
  int? expiresIn;

  token_model({this.status, this.id, this.token, this.type, this.expiresIn});

  token_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    token = json['token'];
    type = json['type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['token'] = this.token;
    data['type'] = this.type;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}
