class AddressModel {
  String? first_name;
  String? last_name;
  String? state;
  String? statename;
  String? phone;
  String? email;
  String? address;
  bool? check;

  AddressModel(
      {this.first_name,
      this.last_name,
      this.state,
      this.statename,
      this.phone,
      this.email,
      this.address,
      this.check});

  AddressModel.fromJson(Map<String, dynamic> json) {
    first_name = json['first_name'];
    last_name = json['last_name'];
    state = json['state'];
    statename = json['statename'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    check = json['check'];
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'state': state,
      'statename': statename,
      'phone': phone,
      'email': email,
      'address': address,
      'check': check
    };
  }
}
