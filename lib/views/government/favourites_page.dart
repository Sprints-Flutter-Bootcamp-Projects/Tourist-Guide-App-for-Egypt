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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextTitle(
                context.tr("favourite_places"),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
      ),
    );
  }
}
