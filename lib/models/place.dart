import 'dart:math';

class Place {
  final String name;
  final String img;
  final String address;
  final double latitude;
  final double longitude;

  Place({
    required this.name,
    required this.img,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  double distance( double lat, double lng){
        var p = 0.017453292519943295;
        var c = cos;
        var a = 0.5 - c((lat - latitude) * p)/2 +
            c(latitude * p) * c(lat * p) *
                (1 - c((lng - longitude) * p))/2;
        return 12742 * asin(sqrt(a));
  }

  factory Place.fromData(Map data) {
    return Place(
      name: data["name"] ?? "",
      img: data["img"] ?? "",
      address: data["address"] ?? "",
      latitude: data["latitude"] ?? 0,
      longitude: data["longitude"] ?? 0,
    );
  }
}