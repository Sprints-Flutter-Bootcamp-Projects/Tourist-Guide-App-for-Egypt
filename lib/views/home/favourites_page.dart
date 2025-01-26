import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/navigation/app_drawer.dart';

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
      appBar: AppBar(
        title: Text(tr("favorites")),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            favList.isEmpty
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
