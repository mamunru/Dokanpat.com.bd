import 'package:dokanpat/model/product_model.dart';

class cartModel {
  int? product_id;
  String? name;
  String? price;
  String? regularPrice;
  int? quantity;
  int? variation_id;
  String? variationValue;
  String? src;
  bool? check;
  bool? tagstatus;
  productModel? product;

  cartModel(
      {this.product_id,
      this.name,
      this.price,
      this.regularPrice,
      this.quantity,
      this.variation_id,
      this.variationValue,
      this.src,
      this.check,
      this.tagstatus,
      this.product});

  cartModel.fromJson(Map<String, dynamic> json) {
    product_id = json['product_id'];
    name = json['name'];
    price = json['price'];
    regularPrice = json['regular_price'];
    quantity = json['quantity'];
    variation_id = json['variation_id'];
    variationValue = json['variation_value'];
    src = json['src'];
    check = json['check'];
    tagstatus = json['tagstatus'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.product_id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['quantity'] = this.quantity;
    data['variation_id'] = this.variation_id;
    data['variation_value'] = this.variationValue;
    data['src'] = this.src;
    data['check'] = this.check;
    data['tagstatus'] = this.tagstatus;
    return data;
  }
}
