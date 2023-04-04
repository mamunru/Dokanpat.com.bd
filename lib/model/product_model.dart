class productModel {
  int? id;
  String? name;
  String? slug;
  String? permalink;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? type;
  String? status;
  bool? featured;
  String? catalogVisibility;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  Null? dateOnSaleFrom;
  Null? dateOnSaleFromGmt;
  Null? dateOnSaleTo;
  Null? dateOnSaleToGmt;
  bool? onSale;
  bool? purchasable;
  // int? totalSales;
  bool? virtual;
  String? externalUrl;
  String? buttonText;
  String? taxStatus;
  String? taxClass;
  bool? manageStock;
  //Null? stockQuantity;
  String? backorders;
  bool? backordersAllowed;
  bool? backordered;
  //Null? lowStockAmount;
  bool? soldIndividually;
  String? weight;
  Dimensions? dimensions;
  bool? shippingRequired;
  bool? shippingTaxable;
  String? shippingClass;
  int? shippingClassId;
  bool? reviewsAllowed;
  String? averageRating;
  int? ratingCount;
  List<int>? upsellIds;
  int? parentId;
  String? purchaseNote;
  List<Categories>? categories;
  List<Tags>? tags;
  List<Images>? images;
  List<Attributes>? attributes;
  List<int>? variations;
  int? menuOrder;
  String? priceHtml;
  List<int>? relatedIds;
  //List<MetaData>? metaData;
  String? stockStatus;
  bool? hasOptions;
  bool? isPurchased;
  List<VariationProducts>? variationProducts;
  List<AttributesData>? attributesData;
  Links? lLinks;

  productModel(
      {this.id,
      this.name,
      this.slug,
      this.permalink,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.type,
      this.status,
      this.featured,
      this.catalogVisibility,
      this.description,
      this.shortDescription,
      this.sku,
      this.price,
      this.regularPrice,
      this.salePrice,
      this.dateOnSaleFrom,
      this.dateOnSaleFromGmt,
      this.dateOnSaleTo,
      this.dateOnSaleToGmt,
      this.onSale,
      this.purchasable,
      //this.totalSales,
      this.virtual,
      this.externalUrl,
      this.buttonText,
      this.taxStatus,
      this.taxClass,
      this.manageStock,
      // this.stockQuantity,
      this.backorders,
      this.backordersAllowed,
      this.backordered,
      // this.lowStockAmount,
      this.soldIndividually,
      this.weight,
      this.dimensions,
      this.shippingRequired,
      this.shippingTaxable,
      this.shippingClass,
      this.shippingClassId,
      this.reviewsAllowed,
      this.averageRating,
      this.ratingCount,
      this.upsellIds,
      this.parentId,
      this.purchaseNote,
      this.categories,
      this.tags,
      this.images,
      this.attributes,
      this.variations,
      this.menuOrder,
      this.priceHtml,
      this.relatedIds,
      // this.metaData,
      this.stockStatus,
      this.hasOptions,
      this.isPurchased,
      this.variationProducts,
      this.attributesData,
      this.lLinks});

  productModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    permalink = json['permalink'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    type = json['type'];
    status = json['status'];
    featured = json['featured'];
    catalogVisibility = json['catalog_visibility'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    dateOnSaleFrom = json['date_on_sale_from'];
    dateOnSaleFromGmt = json['date_on_sale_from_gmt'];
    dateOnSaleTo = json['date_on_sale_to'];
    dateOnSaleToGmt = json['date_on_sale_to_gmt'];
    onSale = json['on_sale'];
    purchasable = json['purchasable'];
    // totalSales = json['total_sales'];
    virtual = json['virtual'];
    externalUrl = json['external_url'];
    buttonText = json['button_text'];
    taxStatus = json['tax_status'];
    taxClass = json['tax_class'];
    manageStock = json['manage_stock'];
    backorders = json['backorders'];
    backordersAllowed = json['backorders_allowed'];
    backordered = json['backordered'];
    // lowStockAmount = json['low_stock_amount'];
    soldIndividually = json['sold_individually'];
    weight = json['weight'];
    dimensions = json['dimensions'] != null
        ? new Dimensions.fromJson(json['dimensions'])
        : null;
    shippingRequired = json['shipping_required'];
    shippingTaxable = json['shipping_taxable'];
    shippingClass = json['shipping_class'];
    shippingClassId = json['shipping_class_id'];
    reviewsAllowed = json['reviews_allowed'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    upsellIds = json['upsell_ids'].cast<int>();
    parentId = json['parent_id'];
    purchaseNote = json['purchase_note'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    variations = json['variations'].cast<int>();
    menuOrder = json['menu_order'];
    priceHtml = json['price_html'];
    relatedIds = json['related_ids'].cast<int>();
    // if (json['meta_data'] != null) {
    //   metaData = <MetaData>[];
    //   json['meta_data'].forEach((v) {
    //     metaData!.add(new MetaData.fromJson(v));
    //   });
    // }
    stockStatus = json['stock_status'];
    hasOptions = json['has_options'];

    isPurchased = json['is_purchased'];
    if (json['variation_products'] != null) {
      variationProducts = <VariationProducts>[];
      json['variation_products'].forEach((v) {
        variationProducts!.add(new VariationProducts.fromJson(v));
      });
    }
    if (json['attributesData'] != null) {
      attributesData = <AttributesData>[];
      json['attributesData'].forEach((v) {
        attributesData!.add(new AttributesData.fromJson(v));
      });
    }
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['permalink'] = this.permalink;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['type'] = this.type;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['catalog_visibility'] = this.catalogVisibility;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['date_on_sale_from'] = this.dateOnSaleFrom;
    data['date_on_sale_from_gmt'] = this.dateOnSaleFromGmt;
    data['date_on_sale_to'] = this.dateOnSaleTo;
    data['date_on_sale_to_gmt'] = this.dateOnSaleToGmt;
    data['on_sale'] = this.onSale;
    data['purchasable'] = this.purchasable;
    // data['total_sales'] = this.totalSales;
    data['virtual'] = this.virtual;
    data['external_url'] = this.externalUrl;
    data['button_text'] = this.buttonText;
    data['tax_status'] = this.taxStatus;
    data['tax_class'] = this.taxClass;
    data['manage_stock'] = this.manageStock;
    //data['stock_quantity'] = this.stockQuantity;
    data['backorders'] = this.backorders;
    data['backorders_allowed'] = this.backordersAllowed;
    data['backordered'] = this.backordered;
    //data['low_stock_amount'] = this.lowStockAmount;
    data['sold_individually'] = this.soldIndividually;
    data['weight'] = this.weight;
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions!.toJson();
    }
    data['shipping_required'] = this.shippingRequired;
    data['shipping_taxable'] = this.shippingTaxable;
    data['shipping_class'] = this.shippingClass;
    data['shipping_class_id'] = this.shippingClassId;
    data['reviews_allowed'] = this.reviewsAllowed;
    data['average_rating'] = this.averageRating;
    data['rating_count'] = this.ratingCount;
    data['upsell_ids'] = this.upsellIds;
    data['parent_id'] = this.parentId;
    data['purchase_note'] = this.purchaseNote;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    data['variations'] = this.variations;
    data['menu_order'] = this.menuOrder;
    data['price_html'] = this.priceHtml;
    data['related_ids'] = this.relatedIds;
    // if (this.metaData != null) {
    //   data['meta_data'] = this.metaData!.map((v) => v.toJson()).toList();
    // }
    data['stock_status'] = this.stockStatus;
    data['has_options'] = this.hasOptions;

    data['is_purchased'] = this.isPurchased;
    if (this.variationProducts != null) {
      data['variation_products'] =
          this.variationProducts!.map((v) => v.toJson()).toList();
    }

    if (this.attributesData != null) {
      data['attributesData'] =
          this.attributesData!.map((v) => v.toJson()).toList();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    return data;
  }
}

class Dimensions {
  String? length;
  String? width;
  String? height;

  Dimensions({this.length, this.width, this.height});

  Dimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? slug;

  Categories({this.id, this.name, this.slug});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class Tags {
  int? id;
  String? name;
  String? slug;

  Tags({this.id, this.name, this.slug});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class Images {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;

  Images(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.src,
      this.name,
      this.alt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['src'] = this.src;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}

class Attributes {
  int? id;
  String? name;
  int? position;
  bool? visible;
  bool? variation;
  List<String>? options;

  Attributes(
      {this.id,
      this.name,
      this.position,
      this.visible,
      this.variation,
      this.options});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    position = json['position'];
    visible = json['visible'];
    variation = json['variation'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    data['visible'] = this.visible;
    data['variation'] = this.variation;
    data['options'] = this.options;
    return data;
  }
}

class YoastHeadJson {
  String? title;
  Robots? robots;
  String? canonical;
  String? ogLocale;
  String? ogType;
  String? ogTitle;
  String? ogUrl;
  String? ogSiteName;
  String? articleModifiedTime;
  List<OgImage>? ogImage;
  String? twitterCard;
  TwitterMisc? twitterMisc;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.robots != null) {
      data['robots'] = this.robots!.toJson();
    }
    data['canonical'] = this.canonical;
    data['og_locale'] = this.ogLocale;
    data['og_type'] = this.ogType;
    data['og_title'] = this.ogTitle;
    data['og_url'] = this.ogUrl;
    data['og_site_name'] = this.ogSiteName;
    data['article_modified_time'] = this.articleModifiedTime;
    if (this.ogImage != null) {
      data['og_image'] = this.ogImage!.map((v) => v.toJson()).toList();
    }
    data['twitter_card'] = this.twitterCard;
    if (this.twitterMisc != null) {
      data['twitter_misc'] = this.twitterMisc!.toJson();
    }

    return data;
  }
}

class Robots {
  String? index;
  String? follow;
  String? maxSnippet;
  String? maxImagePreview;
  String? maxVideoPreview;

  Robots(
      {this.index,
      this.follow,
      this.maxSnippet,
      this.maxImagePreview,
      this.maxVideoPreview});

  Robots.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    follow = json['follow'];
    maxSnippet = json['max-snippet'];
    maxImagePreview = json['max-image-preview'];
    maxVideoPreview = json['max-video-preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['follow'] = this.follow;
    data['max-snippet'] = this.maxSnippet;
    data['max-image-preview'] = this.maxImagePreview;
    data['max-video-preview'] = this.maxVideoPreview;
    return data;
  }
}

class OgImage {
  int? width;
  int? height;
  String? url;
  String? type;

  OgImage({this.width, this.height, this.url, this.type});

  OgImage.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}

class TwitterMisc {
  String? estReadingTime;

  TwitterMisc({this.estReadingTime});

  TwitterMisc.fromJson(Map<String, dynamic> json) {
    estReadingTime = json['Est. reading time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Est. reading time'] = this.estReadingTime;
    return data;
  }
}

class Graph {
  String? type;
  String? id;
  String? url;
  String? name;
  IsPartOf? isPartOf;
  String? datePublished;
  String? dateModified;
  IsPartOf? breadcrumb;
  String? inLanguage;
  List<PotentialAction>? potentialAction;
  List<ItemListElement>? itemListElement;
  String? description;
  IsPartOf? publisher;
  Logo? logo;
  IsPartOf? image;

  Graph(
      {this.type,
      this.id,
      this.url,
      this.name,
      this.isPartOf,
      this.datePublished,
      this.dateModified,
      this.breadcrumb,
      this.inLanguage,
      this.potentialAction,
      this.itemListElement,
      this.description,
      this.publisher,
      this.logo,
      this.image});

  Graph.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    id = json['@id'];
    url = json['url'];
    name = json['name'];
    isPartOf = json['isPartOf'] != null
        ? new IsPartOf.fromJson(json['isPartOf'])
        : null;
    datePublished = json['datePublished'];
    dateModified = json['dateModified'];
    breadcrumb = json['breadcrumb'] != null
        ? new IsPartOf.fromJson(json['breadcrumb'])
        : null;
    inLanguage = json['inLanguage'];
    if (json['potentialAction'] != null) {
      potentialAction = <PotentialAction>[];
      json['potentialAction'].forEach((v) {
        potentialAction!.add(new PotentialAction.fromJson(v));
      });
    }
    if (json['itemListElement'] != null) {
      itemListElement = <ItemListElement>[];
      json['itemListElement'].forEach((v) {
        itemListElement!.add(new ItemListElement.fromJson(v));
      });
    }
    description = json['description'];
    publisher = json['publisher'] != null
        ? new IsPartOf.fromJson(json['publisher'])
        : null;
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    image = json['image'] != null ? new IsPartOf.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['@id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    if (this.isPartOf != null) {
      data['isPartOf'] = this.isPartOf!.toJson();
    }
    data['datePublished'] = this.datePublished;
    data['dateModified'] = this.dateModified;
    if (this.breadcrumb != null) {
      data['breadcrumb'] = this.breadcrumb!.toJson();
    }
    data['inLanguage'] = this.inLanguage;
    if (this.potentialAction != null) {
      data['potentialAction'] =
          this.potentialAction!.map((v) => v.toJson()).toList();
    }
    if (this.itemListElement != null) {
      data['itemListElement'] =
          this.itemListElement!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    if (this.publisher != null) {
      data['publisher'] = this.publisher!.toJson();
    }
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}

class IsPartOf {
  String? id;

  IsPartOf({this.id});

  IsPartOf.fromJson(Map<String, dynamic> json) {
    id = json['@id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@id'] = this.id;
    return data;
  }
}

class PotentialAction {
  String? type;
  List<String>? target;
  String? queryInput;

  PotentialAction({this.type, this.target, this.queryInput});

  PotentialAction.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    target = json['target'].cast<String>();
    queryInput = json['query-input'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['target'] = this.target;
    data['query-input'] = this.queryInput;
    return data;
  }
}

class ItemListElement {
  String? type;
  int? position;
  String? name;
  String? item;

  ItemListElement({this.type, this.position, this.name, this.item});

  ItemListElement.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    position = json['position'];
    name = json['name'];
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['position'] = this.position;
    data['name'] = this.name;
    data['item'] = this.item;
    return data;
  }
}

class Logo {
  String? type;
  String? inLanguage;
  String? id;
  String? url;
  String? contentUrl;
  int? width;
  int? height;
  String? caption;

  Logo(
      {this.type,
      this.inLanguage,
      this.id,
      this.url,
      this.contentUrl,
      this.width,
      this.height,
      this.caption});

  Logo.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    inLanguage = json['inLanguage'];
    id = json['@id'];
    url = json['url'];
    contentUrl = json['contentUrl'];
    width = json['width'];
    height = json['height'];
    caption = json['caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['inLanguage'] = this.inLanguage;
    data['@id'] = this.id;
    data['url'] = this.url;
    data['contentUrl'] = this.contentUrl;
    data['width'] = this.width;
    data['height'] = this.height;
    data['caption'] = this.caption;
    return data;
  }
}

class VariationProducts {
  int? id;
  int? productId;
  String? price;
  String? regularPrice;
  String? salePrice;
  Null? dateOnSaleFrom;
  Null? dateOnSaleTo;
  bool? onSale;
  bool? inStock;
  //Null? stockQuantity;
  String? stockStatus;
  String? featureImage;
  List<AttributesArr>? attributesArr;

  VariationProducts(
      {this.id,
      this.productId,
      this.price,
      this.regularPrice,
      this.salePrice,
      this.dateOnSaleFrom,
      this.dateOnSaleTo,
      this.onSale,
      this.inStock,
      //this.stockQuantity,
      this.stockStatus,
      this.featureImage,
      this.attributesArr});

  VariationProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    dateOnSaleFrom = json['date_on_sale_from'];
    dateOnSaleTo = json['date_on_sale_to'];
    onSale = json['on_sale'];
    inStock = json['in_stock'];
    // stockQuantity = json['stock_quantity'];
    stockStatus = json['stock_status'];
    featureImage = json['feature_image'];
    if (json['attributes_arr'] != null) {
      attributesArr = <AttributesArr>[];
      json['attributes_arr'].forEach((v) {
        attributesArr!.add(new AttributesArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['date_on_sale_from'] = this.dateOnSaleFrom;
    data['date_on_sale_to'] = this.dateOnSaleTo;
    data['on_sale'] = this.onSale;
    data['in_stock'] = this.inStock;
    //data['stock_quantity'] = this.stockQuantity;
    data['stock_status'] = this.stockStatus;
    data['feature_image'] = this.featureImage;
    if (this.attributesArr != null) {
      data['attributes_arr'] =
          this.attributesArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttributesArr {
  String? name;
  String? slug;
  String? attributeName;

  AttributesArr({this.name, this.slug, this.attributeName});

  AttributesArr.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    attributeName = json['attribute_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['attribute_name'] = this.attributeName;
    return data;
  }
}

class AttributesData {
  int? id;
  String? name;
  List<Options>? options;
  int? position;
  bool? visible;
  bool? variation;
  int? isVisible;
  int? isVariation;
  int? isTaxonomy;
  String? value;
  String? label;

  AttributesData(
      {this.id,
      this.name,
      this.options,
      this.position,
      this.visible,
      this.variation,
      this.isVisible,
      this.isVariation,
      this.isTaxonomy,
      this.value,
      this.label});

  AttributesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    position = json['position'];
    visible = json['visible'];
    variation = json['variation'];
    isVisible = json['is_visible'];
    isVariation = json['is_variation'];
    isTaxonomy = json['is_taxonomy'];
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['position'] = this.position;
    data['visible'] = this.visible;
    data['variation'] = this.variation;
    data['is_visible'] = this.isVisible;
    data['is_variation'] = this.isVariation;
    data['is_taxonomy'] = this.isTaxonomy;
    data['value'] = this.value;
    data['label'] = this.label;
    return data;
  }
}

class Options {
  int? termId;
  String? name;
  String? slug;
  int? termGroup;
  int? termTaxonomyId;
  String? taxonomy;
  String? description;
  int? parent;
  int? count;
  String? filter;

  Options(
      {this.termId,
      this.name,
      this.slug,
      this.termGroup,
      this.termTaxonomyId,
      this.taxonomy,
      this.description,
      this.parent,
      this.count,
      this.filter});

  Options.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
    termTaxonomyId = json['term_taxonomy_id'];
    taxonomy = json['taxonomy'];
    description = json['description'];
    parent = json['parent'];
    count = json['count'];
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['term_id'] = this.termId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['term_group'] = this.termGroup;
    data['term_taxonomy_id'] = this.termTaxonomyId;
    data['taxonomy'] = this.taxonomy;
    data['description'] = this.description;
    data['parent'] = this.parent;
    data['count'] = this.count;
    data['filter'] = this.filter;
    return data;
  }
}

class Links {
  List<Self>? self;

  Links({this.self});

  Links.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <Self>[];
      json['self'].forEach((v) {
        self!.add(new Self.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}
