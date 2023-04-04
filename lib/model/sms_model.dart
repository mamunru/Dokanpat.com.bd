class smsModel {
  int? id;
  String? userid;
  String? title;
  String? message;
  String? image;

  smsModel({this.id, this.userid, this.title, this.message, this.image});

  smsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    title = json['title'];
    message = json['message'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['title'] = this.title;
    data['message'] = this.message;
    data['image'] = this.image;
    return data;
  }
}
