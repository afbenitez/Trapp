import 'package:trapp_flutter/models/city.dart';

class Trip {
  final String name;
  final String img;
  final int price;
  final int reviews;
  final double? rating;
  final Object? destination;

  Trip({
    required this.name,
    required this.img,
    required this.reviews,
    required this.rating,
    required this.price,
    required this.destination,
  });

  factory Trip.fromData(Map data) {
    return Trip(
      name: data["name"] ?? "cartage",
      img: data["img"] ?? "",
      reviews: data["reviews"] ?? "",
      rating: data["rating"] ?? 0,
      price: data["price"] ?? 0,
      destination: data["destination"],
    );
  }
}