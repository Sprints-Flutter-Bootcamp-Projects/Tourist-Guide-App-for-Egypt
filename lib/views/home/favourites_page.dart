import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/app_drawer.dart';
import 'package:tourist_guide/models/place_model.dart';
import 'package:tourist_guide/services/firebase_service_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourist_guide/utils/widgets/grid_item.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List<Place> favPlaces = [];

  @override
  void initState() {
    super.initState();
    _listenToFavouritePlaces();
  }

  void _listenToFavouritePlaces() async {
    var userData = await FirebaseServiceAuth().fetchCurrentUser();
    if (userData != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userData.id)
          .collection('favorites')
          .snapshots()
          .listen((snapshot) {
        List<Place> places = snapshot.docs.map((doc) {
          return Place.fromJson(doc.data());
        }).toList();

        setState(() {
          favPlaces = places;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("favorites")),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            favPlaces.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        context.tr("fav_desc"),
                        style: TextStyle(
                            color: Colors.teal[800],
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: favPlaces.length,
                      itemBuilder: (context, index) {
                        return GridItem(
                          place: favPlaces[index],
                          // isFavourite: favPlaces[index].addedToFavorite,
                          isFavourite: true,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
