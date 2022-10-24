class BuisnessProfile {
  BuisnessProfile({
    this.id,
    this.logo,
    this.title,
    this.category,
    this.email,
    this.contactNo,
    this.address,
    this.description,
    this.coverPhoto,
    this.rating,
    this.noOfReviews,
    this.district,
    this.gallery,
    this.reviews,
    this.packages,
    this.services,
  });

  String? id;
  String? logo;
  String? title;
  String? description;
  String? coverPhoto;
  String? category;
  String? email;
  String? contactNo;
  String? address;
  String? district;
  double? rating;
  int? noOfReviews;
  List<dynamic>? services;
  List<dynamic>? gallery;
  List<dynamic>? packages;
  List<dynamic>? reviews;
}
