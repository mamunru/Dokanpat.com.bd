class reviewModel {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  int? productId;
  String? productName;
  String? productPermalink;
  String? status;
  String? reviewer;
  String? reviewerEmail;
  String? review;
  int? rating;
  bool? verified;

  reviewModel(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.productId,
      this.productName,
      this.productPermalink,
      this.status,
      this.reviewer,
      this.reviewerEmail,
      this.review,
      this.rating,
      this.verified});

  reviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    productId = json['product_id'];
    productName = json['product_name'];
    productPermalink = json['product_permalink'];
    status = json['status'];
    reviewer = json['reviewer'];
    reviewerEmail = json['reviewer_email'];
    review = json['review'];
    rating = json['rating'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_permalink'] = this.productPermalink;
    data['status'] = this.status;
    data['reviewer'] = this.reviewer;
    data['reviewer_email'] = this.reviewerEmail;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['verified'] = this.verified;

    return data;
  }
}
