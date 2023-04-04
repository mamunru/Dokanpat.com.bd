class shoppingMethodModel {
  int? id;
  int? instanceId;
  String? title;
  int? order;
  bool? enabled;
  String? methodId;
  String? methodTitle;
  String? methodDescription;
  Settings? settings;

  shoppingMethodModel(
      {this.id,
      this.instanceId,
      this.title,
      this.order,
      this.enabled,
      this.methodId,
      this.methodTitle,
      this.methodDescription,
      this.settings});

  shoppingMethodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instanceId = json['instance_id'];
    title = json['title'];
    order = json['order'];
    enabled = json['enabled'];
    methodId = json['method_id'];
    methodTitle = json['method_title'];
    methodDescription = json['method_description'];
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['instance_id'] = this.instanceId;
    data['title'] = this.title;
    data['order'] = this.order;
    data['enabled'] = this.enabled;
    data['method_id'] = this.methodId;
    data['method_title'] = this.methodTitle;
    data['method_description'] = this.methodDescription;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class Settings {
  Title? title;
  Title? cost;

  Settings({this.title, this.cost});

  Settings.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    cost = json['cost'] != null ? new Title.fromJson(json['cost']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    if (this.cost != null) {
      data['cost'] = this.cost!.toJson();
    }
    return data;
  }
}

class Title {
  String? id;
  String? label;
  String? description;
  String? type;
  String? value;
  String? tip;

  Title(
      {this.id, this.label, this.description, this.type, this.value, this.tip});

  Title.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    description = json['description'];
    type = json['type'];
    value = json['value'];
    tip = json['tip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['description'] = this.description;
    data['type'] = this.type;
    data['value'] = this.value;
    data['tip'] = this.tip;
    return data;
  }
}
