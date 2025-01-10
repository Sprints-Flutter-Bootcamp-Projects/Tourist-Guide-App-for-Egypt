import 'package:flutter/material.dart';
import 'package:tourist_guide/nav_bar.dart';
import 'package:tourist_guide/views/home/favourites_page.dart';

class GridItem extends StatefulWidget {
  GridItem(BuildContext context, this.imgURL, this.title, this.subhead,
      {super.key, this.isFavourite = false});
  final String imgURL;
  final String title;
  final String subhead;
  bool isFavourite;
  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                child: Image.asset(
                  "assets/images/pyramids.jpg",
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image,
                        size: 50, color: Colors.grey);
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                tileColor: Colors.teal[50],
                title: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.teal[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                ),
                subtitle: Text(
                  widget.subhead,
                  style: const TextStyle(fontSize: 13),
                ),
                trailing: IconButton.filledTonal(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.teal[100])),
                  color: Colors.teal[900],
                  onPressed: () {
                    if (isLoggedIn) {
                      if (widget.isFavourite) {
                        setState(() {
                          widget.isFavourite = false;
                          favList.remove(widget);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Item removed from Favourites')));
                      } else {
                        setState(() {
                          favList.add(widget);
                          widget.isFavourite = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Item added to Favorites")),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("You Must Login First")),
                      );
                    }
                  },
                  icon: Icon(
                    widget.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
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
}
