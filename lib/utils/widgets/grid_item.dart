import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/models/place_model.dart';
import 'package:tourist_guide/views/home/favourites_page.dart';

import '../helpers/shared_pref.dart';

class GridItem extends StatefulWidget {
  final Place place;
  bool isFavourite;

  GridItem({super.key, required this.place, this.isFavourite = false});

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>?> userData =
        SharedPreferencesHelper.getUserData();

    return SizedBox(
      height: 180,
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: DecorationImage(
                  image: NetworkImage(widget.place.image),
                  fit: BoxFit.cover,
                  opacity: 0.5,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Image.network(
                  widget.place.image,
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
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 6.0), // Adjust the horizontal padding as needed
                title: Text(
                  tr(widget.place.name),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                ),
                subtitle: Text(
                  tr(widget.place.location),
                  style: const TextStyle(fontSize: 11),
                ),
                trailing: IconButton.filledTonal(
                  onPressed: () {
                    if (userData != null) {
                      if (widget.isFavourite) {
                        setState(() {
                          widget.place.addedToFavorite = false;
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
