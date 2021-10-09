class ProductModel {
  final String title;
  final String image;
  final int likeCount;
  final int dislikeCount;
  final double? rating;

  ProductModel({
    required this.title,
    required this.image,
    this.likeCount = 0,
    this.dislikeCount = 0,
    this.rating,
  });

  factory ProductModel.fromData(Map data) {
    return ProductModel(
      title: data["title"] ?? "Product Title",
      image: data["image"] ?? "Product Title",
      likeCount: data["likeCount"] ?? 0,
      dislikeCount: data["dislikeCount"] ?? 0,
      rating: data["rating"] ?? null,
    );
  }
}
