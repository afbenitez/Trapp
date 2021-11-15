class Trip {
  final String id;
  final String name;
  final String img;
  final int price;
  final int reviews;
  final double? rating;

  Trip({
    required this.id,
    required this.name,
    required this.img,
    required this.reviews,
    required this.rating,
    required this.price,
  });

  factory Trip.fromData(Map data) {
    return Trip(
      id: data["id"]?? "idhandler",
      name: data["name"] ?? "cartage",
      img: data["img"] ?? "",
      reviews: data["reviews"] ?? "",
      rating: data["rating"] ?? 0,
      price: data["price"] ?? 0,
    );
  }
}