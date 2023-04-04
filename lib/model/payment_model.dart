class PaymentModel {
  String? id;
  String? title;
  String? description;
  int? order;
  bool? enabled;
  String? methodTitle;
  String? methodDescription;
  List<String>? methodSupports;
  Settings? settings;
  bool? needsSetup;
  String? settingsUrl;

  PaymentModel(
      {this.id,
      this.title,
      this.description,
      this.order,
      this.enabled,
      this.methodTitle,
      this.methodDescription,
      this.methodSupports,
      this.settings,
      this.needsSetup,
      this.settingsUrl});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    order = json['order'];
    enabled = json['enabled'];
    methodTitle = json['method_title'];
    methodDescription = json['method_description'];
    methodSupports = json['method_supports'].cast<String>();
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    needsSetup = json['needs_setup'];
    settingsUrl = json['settings_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['order'] = this.order;
    data['enabled'] = this.enabled;
    data['method_title'] = this.methodTitle;
    data['method_description'] = this.methodDescription;
    data['method_supports'] = this.methodSupports;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    data['needs_setup'] = this.needsSetup;
    data['settings_url'] = this.settingsUrl;
    return data;
  }
}

class Settings {
  Title? title;
  OrderStatus? orderStatus;
  Title? bkashNumber;
  NumberType? numberType;
  Title? bkashCharge;
  Title? instructions;

  Settings(
      {this.title,
      this.orderStatus,
      this.bkashNumber,
      this.numberType,
      this.bkashCharge,
      this.instructions});

  Settings.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    orderStatus = json['order_status'] != null
        ? new OrderStatus.fromJson(json['order_status'])
        : null;
    bkashNumber = json['bkash_number'] != null
        ? new Title.fromJson(json['bkash_number'])
        : null;
    numberType = json['number_type'] != null
        ? new NumberType.fromJson(json['number_type'])
        : null;
    bkashCharge = json['bkash_charge'] != null
        ? new Title.fromJson(json['bkash_charge'])
        : null;
    instructions = json['instructions'] != null
        ? new Title.fromJson(json['instructions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    if (this.orderStatus != null) {
      data['order_status'] = this.orderStatus!.toJson();
    }
    if (this.bkashNumber != null) {
      data['bkash_number'] = this.bkashNumber!.toJson();
    }
    if (this.numberType != null) {
      data['number_type'] = this.numberType!.toJson();
    }
    if (this.bkashCharge != null) {
      data['bkash_charge'] = this.bkashCharge!.toJson();
    }
    if (this.instructions != null) {
      data['instructions'] = this.instructions!.toJson();
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
  String? placeholder;

  Title(
      {this.id,
      this.label,
      this.description,
      this.type,
      this.value,
      this.tip,
      this.placeholder});

  Title.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    description = json['description'];
    type = json['type'];
    value = json['value'];
    tip = json['tip'];
    placeholder = json['placeholder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['description'] = this.description;
    data['type'] = this.type;
    data['value'] = this.value;
    data['tip'] = this.tip;
    data['placeholder'] = this.placeholder;
    return data;
  }
}

class OrderStatus {
  String? id;
  String? label;
  String? description;
  String? type;
  String? value;
  String? tip;
  String? placeholder;
  Options? options;

  OrderStatus(
      {this.id,
      this.label,
      this.description,
      this.type,
      this.value,
      this.tip,
      this.placeholder,
      this.options});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    description = json['description'];
    type = json['type'];
    value = json['value'];
    tip = json['tip'];
    placeholder = json['placeholder'];
    options =
        json['options'] != null ? new Options.fromJson(json['options']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['description'] = this.description;
    data['type'] = this.type;
    data['value'] = this.value;
    data['tip'] = this.tip;
    data['placeholder'] = this.placeholder;
    if (this.options != null) {
      data['options'] = this.options!.toJson();
    }
    return data;
  }
}

class Options {
  String? wcPending;
  String? wcProcessing;
  String? wcRefundReq;
  String? wcOnHold;
  String? wcCompleted;
  String? wcCancelled;
  String? wcRefunded;
  String? wcFailed;
  String? wcCheckoutDraft;

  Options(
      {this.wcPending,
      this.wcProcessing,
      this.wcRefundReq,
      this.wcOnHold,
      this.wcCompleted,
      this.wcCancelled,
      this.wcRefunded,
      this.wcFailed,
      this.wcCheckoutDraft});

  Options.fromJson(Map<String, dynamic> json) {
    wcPending = json['wc-pending'];
    wcProcessing = json['wc-processing'];
    wcRefundReq = json['wc-refund-req'];
    wcOnHold = json['wc-on-hold'];
    wcCompleted = json['wc-completed'];
    wcCancelled = json['wc-cancelled'];
    wcRefunded = json['wc-refunded'];
    wcFailed = json['wc-failed'];
    wcCheckoutDraft = json['wc-checkout-draft'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wc-pending'] = this.wcPending;
    data['wc-processing'] = this.wcProcessing;
    data['wc-refund-req'] = this.wcRefundReq;
    data['wc-on-hold'] = this.wcOnHold;
    data['wc-completed'] = this.wcCompleted;
    data['wc-cancelled'] = this.wcCancelled;
    data['wc-refunded'] = this.wcRefunded;
    data['wc-failed'] = this.wcFailed;
    data['wc-checkout-draft'] = this.wcCheckoutDraft;
    return data;
  }
}

class NumberType {
  String? id;
  String? label;
  String? description;
  String? type;
  String? value;
  String? tip;
  String? placeholder;
  Optionstype? optionstype;

  NumberType(
      {this.id,
      this.label,
      this.description,
      this.type,
      this.value,
      this.tip,
      this.placeholder,
      this.optionstype});

  NumberType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    description = json['description'];
    type = json['type'];
    value = json['value'];
    tip = json['tip'];
    placeholder = json['placeholder'];
    optionstype = json['options'] != null
        ? new Optionstype.fromJson(json['options'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['description'] = this.description;
    data['type'] = this.type;
    data['value'] = this.value;
    data['tip'] = this.tip;
    data['placeholder'] = this.placeholder;
    if (this.optionstype != null) {
      data['optionstype'] = this.optionstype!.toJson();
    }
    return data;
  }
}

class Optionstype {
  String? agent;
  String? personal;

  Optionstype({this.agent, this.personal});

  Optionstype.fromJson(Map<String, dynamic> json) {
    agent = json['Agent'];
    personal = json['Personal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Agent'] = this.agent;
    data['Personal'] = this.personal;
    return data;
  }
}
