class Trip_fb {
  // This is the user id provided by auth
  final String name;
  final String img;
  final int reviews;
  final double? rating;

  Trip_fb({
    required this.name,
    required this.img,
    this.reviews = 0,
    this.rating,
  });

  factory Trip_fb.fromData(Map data) {
    return Trip_fb(
      name: data["name"] ?? "Trip Title",
      img: data["img"] ?? "Trip Title",
      reviews: data["reviews"] ?? 0,
      rating: data["rating"],
    );
  }
}