class BuisnessProfileCard {
  BuisnessProfileCard({
    required this.id,
    required this.logo,
    required this.title,
    required this.category,
    required this.coverPhoto,
    required this.rating,
    required this.noOfReviews,
  });

  String id;
  String logo;
  String title;
  String coverPhoto;
  String category;
  double rating;
  int noOfReviews;
}
