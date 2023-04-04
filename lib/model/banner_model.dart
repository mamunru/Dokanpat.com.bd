class bannerModel {
  List<Mainbanner>? mainbanner;
  List<Singlebanner>? singlebanner;
  List<Specialbanner>? specialbanner;

  bannerModel({this.mainbanner, this.singlebanner, this.specialbanner});

  bannerModel.fromJson(Map<String, dynamic> json) {
    if (json['mainbanner'] != null) {
      mainbanner = <Mainbanner>[];
      json['mainbanner'].forEach((v) {
        mainbanner!.add(new Mainbanner.fromJson(v));
      });
    }
    if (json['singlebanner'] != null) {
      singlebanner = <Singlebanner>[];
      json['singlebanner'].forEach((v) {
        singlebanner!.add(new Singlebanner.fromJson(v));
      });
    }
    if (json['specialbanner'] != null) {
      specialbanner = <Specialbanner>[];
      json['specialbanner'].forEach((v) {
        specialbanner!.add(new Specialbanner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mainbanner != null) {
      data['mainbanner'] = this.mainbanner!.map((v) => v.toJson()).toList();
    }
    if (this.singlebanner != null) {
      data['singlebanner'] = this.singlebanner!.map((v) => v.toJson()).toList();
    }
    if (this.specialbanner != null) {
      data['specialbanner'] =
          this.specialbanner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mainbanner {
  int? id;
  String? name;
  String? src;
  String? image;
  int? check;
  String? menu;
  String? tag;
  String? product;
  String? show;
  Null? createdAt;
  Null? updatedAt;

  Mainbanner({
    this.id,
    this.name,
    this.src,
    this.image,
    this.check,
    this.menu,
    this.tag,
    this.product,
    this.show,
    this.createdAt,
    this.updatedAt,
  });

  Mainbanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    src = json['src'];
    image = json['image'];
    check = json['check'];
    menu = json['menu'];
    tag = json['tag'];
    product = json['product'];
    show = json['show'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['src'] = this.src;
    data['image'] = this.image;
    data['check'] = this.check;
    data['menu'] = this.menu;
    data['tag'] = this.tag;
    data['product'] = this.product;
    data['show'] = this.show;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}

class Singlebanner {
  int? id;
  String? name;
  String? src;
  String? image;
  int? check;
  String? menu;
  String? tag;
  String? product;
  String? show;
  Null? createdAt;
  Null? updatedAt;
  Null? menuname;

  Singlebanner({
    this.id,
    this.name,
    this.src,
    this.image,
    this.check,
    this.menu,
    this.tag,
    this.product,
    this.show,
    this.createdAt,
    this.updatedAt,
  });

  Singlebanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    src = json['src'];
    image = json['image'];
    check = json['check'];
    menu = json['menu'];
    tag = json['tag'];
    product = json['product'];
    show = json['show'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['src'] = this.src;
    data['image'] = this.image;
    data['check'] = this.check;
    data['menu'] = this.menu;
    data['tag'] = this.tag;
    data['product'] = this.product;
    data['show'] = this.show;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}

class Specialbanner {
  int? id;
  String? name;
  String? src;
  String? image;
  int? size;
  int? check;
  String? menu;
  String? tag;
  String? product;
  String? show;

  Specialbanner(
      {this.id,
      this.name,
      this.src,
      this.image,
      this.size,
      this.check,
      this.menu,
      this.tag,
      this.product,
      this.show});

  Specialbanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    src = json['src'];
    image = json['image'];
    size = json['size'];
    check = json['check'];
    menu = json['menu'];
    tag = json['tag'];
    product = json['product'];
    show = json['show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['src'] = this.src;
    data['image'] = this.image;
    data['size'] = this.size;
    data['check'] = this.check;
    data['menu'] = this.menu;
    data['tag'] = this.tag;
    data['product'] = this.product;
    data['show'] = this.show;
    return data;
  }
}
