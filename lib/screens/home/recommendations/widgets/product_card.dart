import 'package:flutter/material.dart';
import 'package:trapp_flutter/models/trip.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({ required this.data, Key? key, }) : super(key: key);

  final Trip data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 4,
            padding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("You have pressed ${data.name}")),
            );
          },
          child: CardImage(data: data),
        ),
        const SizedBox(height: 15),
        Text(
          data.name,
        ),
        const SizedBox(height: 10),
        Row( //Reviews count
          children: [
            Row(
              children: [
                const Icon(
                  Icons.thumb_up,
                  size: 15,
                ),
                const SizedBox(width: 3),
                Text(
                  data.reviews.toString(),
                )
              ],
            ),
            const SizedBox(width: 10),
            Ratings(rating: data.rating)
          ],
        )
      ],
    );
  }
}

class CardImage extends StatelessWidget {
  const CardImage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Trip data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Image.network(
        data.img,
        height: 160,
        width: 240,
        fit: BoxFit.cover,
        errorBuilder: (_, child, loading) => SizedBox(
          height: 160,
          width: 240,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.error,
              ),
              Text(
                "Could not load url",
              )
            ],
          ),
        ),
        loadingBuilder: (_, child, progress) => progress == null
            ? child
            : SizedBox(
                height: 160,
                width: 240,
                child: Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      value: progress.cumulativeBytesLoaded /
                          progress.expectedTotalBytes!,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class Ratings extends StatelessWidget {
  const Ratings({
    this.rating,
    Key? key,
  }) : super(key: key);

  final double? rating;

  @override
  Widget build(BuildContext context) {
    Icon _icon = Icon(rating != null ? Icons.star : Icons.star_outline,
        color: Colors.lightGreen, size: 15);
    return Row(
      children: [
        _icon,        _icon,        _icon,        _icon,        Icon(rating != null ? Icons.star : Icons.star_outline,
            color: Colors.grey, size: 15),
        const SizedBox(width: 4),
        Text(
          rating != null ? rating.toString() : "NA",
        ),
      ],
    );
  }
}
