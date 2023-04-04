class shoppingAddressModel {
  String? first_name;
  String? last_name;
  String? address_1;
  String? country;
  String? state;
  String? postcode;
  String? email;
  String? phone;

  shoppingAddressModel(
      {this.first_name,
      this.last_name,
      this.address_1,
      this.country,
      this.state,
      this.postcode,
      this.email,
      this.phone});

  shoppingAddressModel.fromJson(Map<String, dynamic> json) {
    first_name = json['first_name'];
    last_name = json['last_name'];
    address_1 = json['regular_last_name'];
    country = 'BD';
    state = json['state'];
    postcode = json['postcode'];
    email = json['email'];
    phone = json['phone'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();

  //   data['first_name'] = this.first_name;
  //   data['last_name'] = this.last_name;
  //   data['regular_last_name'] = this.address_1;
  //   data[''] = this.country;
  //   data['email'] = this.email;
  //   data['phone'] = this.phone;
  //   return data;
  // }
}
