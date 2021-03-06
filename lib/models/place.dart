import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class Place {
  final String id;
  final String name;
  final String img;
  final String address;
  final double latitude;
  final double longitude;
  final List   reviews;

  Place({
    required this.id,
    required this.name,
    required this.img,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.reviews,
  });

  double distance( double lat, double lng){

    // distance between latitudes and longitudes
    double dLat = radians(lat - latitude);
    double dLon = radians(lng - longitude);

    // convert to radians
    double radLat1 = radians(latitude);
    double radLat2 = radians(lat);

    // apply formulae
    num a = pow(sin(dLat/2),2) + pow(sin(dLon/2),2) * cos(radLat1) * cos(radLat2);
    int rad = 6371;
    double c = 2 * asin(sqrt(a));
    return rad * c;
  }

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['id'] = id;
    m['name'] = name;
    m['img'] = img;
    m['address'] = address;
    m['latitude'] = latitude;
    m['longitude'] = longitude;
    m['reviews'] = reviews;

    return m;
  }

  factory Place.fromData(Map data) {
    return Place(
      id: data["id"],
      name: data["name"] ?? "",
      img: data["img"] ?? "",
      address: data["address"] ?? "",
      latitude: data["latitude"] ?? 0,
      longitude: data["longitude"] ?? 0,
      reviews: data["reviews"] ?? List.empty()
    );
  }
}