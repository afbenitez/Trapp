class Activity {

  final String endDate;
  final String name;
  final int price;
  final String startDate;
  final String type;

  Activity({
    required this.endDate,
    required this.name,
    required this.price,
    required this.startDate,
    required this.type
  });

  factory Activity.fromData(Map data) {
    return Activity(
      endDate: data["endDate"] ?? "31/12/2021",
      name: data["name"] ?? "",
      price: data["price"] ?? 0,
      startDate: data["startDate"] ?? "10/11/2021",
      type: data["type"] ?? "",
    );
  }

}