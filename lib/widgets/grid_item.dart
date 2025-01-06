import 'package:flutter/material.dart';
import 'package:tourist_guide/nav_bar.dart';
import 'package:tourist_guide/views/favourites_page.dart';

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
          Expanded(
            child: ListTile(
              title: Text(
                "$title",
                style: TextStyle(fontSize: 10),
              ),
              subtitle: Text(
                "$subhead",
                style: TextStyle(fontSize: 10),
              ),
              trailing: IconButton(
                onPressed: () {
                  if (isLoggedIn) {
                    favList.add(gridItem(context, imgURL, title, subhead));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Added to Favorites")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("You Must Login First")),
                    );
                  }
                },
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.teal,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
