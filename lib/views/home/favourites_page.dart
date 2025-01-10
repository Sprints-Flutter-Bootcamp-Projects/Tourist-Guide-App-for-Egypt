import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/widgets/app_bar.dart';
import 'package:tourist_guide/widgets/text_title.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

List<Widget> favList = [];

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagesAppBar(context, context.tr("favourites")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextTitle(
              context.tr("favourite_places"),
            ),
            const SizedBox(height: 8.0),
            favList.isEmpty
                ? Expanded(
                    child: Center(
                        child: Text(
                    'Starting adding your favourite Places',
                    style: TextStyle(
                        color: Colors.teal[800],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )))
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: favList.length,
                      itemBuilder: (context, index) {
                        return favList[index];
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}