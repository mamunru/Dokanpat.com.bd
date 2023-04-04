class ProductImageModel {
  String? src;
  String? name;

  ProductImageModel({this.src, this.name});

  ProductImageModel.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['src'] = this.src;
    data['name'] = this.name;

    return data;
  }
}
