import 'package:trapp_flutter/models/city.dart';

class Plan {
  final String id;
  final String user_id;
  final String city_name;
  final String name;
  final String img;
  final int price;
  final List trips;
  final List reviews;

  Plan({
    required this.id,
    required this.user_id,
    required this.city_name,
    required this.name,
    required this.img,
    required this.trips,
    required this.reviews,
    required this.price,
  });

  factory Plan.fromData(Map data) {
    return Plan(
      id: data["id"]?? "idhandler",
      user_id: data["user_id"]?? "aWkxfyH1loh5nr6bWDO1Cc6ZLoa2",
      city_name: data["city_name"] ?? "bogota",
      name: data["name"] ?? "Usuario",
      img: data["img"] ?? "",
      trips: data["trips"]??[],
      reviews: data["reviews"] ?? "",
      price: data["price"] ?? 0,
    );
  }
}