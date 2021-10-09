class Trip {
  final String name;
  final String img;
  final int reviews;
  final double? rating;

  Trip({
    required this.name,
    required this.img,
    required this.reviews,
    required this.rating,
  });

  factory Trip.fromData(Map data) {
    return Trip(
      name: data["name"] ?? "Trip Title",
      img: data["img"] ?? "Trip Title",
      reviews: data["reviews"] ?? 0,
      rating: data["rating"],
    );
  }
}