class onscreensmsModel {
  int? id;
  String? title;
  String? message;
  String? image;
  int? check;

  onscreensmsModel({this.id, this.title, this.message, this.image, this.check});

  onscreensmsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    image = json['image'];
    check = json['check'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['image'] = this.image;
    data['check'] = this.check;
    return data;
  }
}
