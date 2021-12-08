import 'package:trapp_flutter/models/city.dart';

class Trip {
  final String id;
  final String name;
  final String img;
  final int price;
  final int reviews;
  final double? rating;
  final Object? destination;

  Trip({
    required this.id,
    required this.name,
    required this.img,
    required this.reviews,
    required this.rating,
    required this.price,
    required this.destination,
  });

  toJSONEncodable() {
    Map<String, dynamic> m = {};

    m['id'] = id;
    m['name'] = name;
    m['img'] = img;
    m['price'] = price;
    m['reviews'] = reviews;
    m['rating'] = rating;

    return m;
  }

  factory Trip.fromData(Map data) {
    return Trip(
      id: data["id"]?? "idhandler",
      name: data["name"] ?? "cartage",
      img: data["img"] ?? "",
      reviews: data["reviews"] ?? "",
      rating: data["rating"] ?? 0,
      price: data["price"] ?? 0,
      destination: data["destination"],
    );
  }
}