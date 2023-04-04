class categoryModel {
  int? id;
  int? pid;
  String? name;
  String? src;
  String? count;
  int? show;
  List<Option>? option;

  categoryModel(
      {this.id,
      this.pid,
      this.name,
      this.src,
      this.count,
      this.show,
      this.option});

  categoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    name = json['name'];
    src = json['src'];
    count = json['count'];
    show = json['show'];
    if (json['option'] != null) {
      option = <Option>[];
      json['option'].forEach((v) {
        option!.add(new Option.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pid'] = this.pid;
    data['name'] = this.name;
    data['src'] = this.src;
    data['count'] = this.count;
    data['show'] = this.show;
    if (this.option != null) {
      data['option'] = this.option!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Option {
  int? id;
  int? pid;
  int? cid;
  String? name;
  String? src;
  String? count;
  int? show;
  List<Sub>? sub;

  Option(
      {this.id,
      this.pid,
      this.cid,
      this.name,
      this.src,
      this.count,
      this.show,
      this.sub});

  Option.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    cid = json['cid'];
    name = json['name'];
    src = json['src'];
    count = json['count'];
    show = json['show'];
    if (json['sub'] != null) {
      sub = <Sub>[];
      json['sub'].forEach((v) {
        sub!.add(new Sub.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pid'] = this.pid;
    data['cid'] = this.cid;
    data['name'] = this.name;
    data['src'] = this.src;
    data['count'] = this.count;
    data['show'] = this.show;
    if (this.sub != null) {
      data['sub'] = this.sub!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sub {
  int? id;
  int? pid;
  int? child;
  int? sub;
  String? name;
  String? src;
  String? count;

  Sub(
      {this.id,
      this.pid,
      this.child,
      this.sub,
      this.name,
      this.src,
      this.count});

  Sub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    child = json['child'];
    sub = json['sub'];
    name = json['name'];
    src = json['src'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pid'] = this.pid;
    data['child'] = this.child;
    data['sub'] = this.sub;
    data['name'] = this.name;
    data['src'] = this.src;
    data['count'] = this.count;
    return data;
  }
}
