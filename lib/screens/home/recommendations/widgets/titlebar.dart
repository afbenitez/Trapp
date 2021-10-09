import 'package:flutter/material.dart';

class TitleRecomended extends StatelessWidget {
  const TitleRecomended({
    Key? key, required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(
                Icons.thumb_up,
              ),
              SizedBox(width: 15),
              Text(
                title,
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Products List"),
              ),
            );
          },
          child: const Text(
            "View All",
            style: TextStyle(
            ),
          ),
        )
      ],
    );
  }
}
