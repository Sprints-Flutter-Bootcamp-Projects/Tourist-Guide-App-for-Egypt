import 'package:flutter/material.dart';

Widget gridItem(
    BuildContext context, String imgURL, String title, String subhead) {
  return Container(
    height: 200,
    width: 200,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              image: DecorationImage(
                image: Image.asset(
                  "assets/images/pyramids.jpg",
                ).image,
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Center(
              // child: Image.network(
              //   imgURL,
              //   height: 90,
              //   width: 60,
              //   fit: BoxFit.contain,
              //   errorBuilder: (context, error, stackTrace) {
              //     return const Icon(Icons.image, size: 50, color: Colors.grey);
              //   },
              // ),
              child: Image.asset(
                "assets/images/pyramids.jpg",
                height: 100,
                width: 100,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image, size: 50, color: Colors.grey);
                },
              ),
            ),
          ),
          ListTile(
            title: Text(
              "$title",
            ),
            subtitle: Text("$subhead"),
            trailing: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Favorites")),
                );
              },
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
