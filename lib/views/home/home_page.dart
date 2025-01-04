import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/widgets/app_bar.dart';
import 'package:tourist_guide/widgets/text_title.dart';

import '../../widgets/grid_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagesAppBar(context, context.tr("home_page")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextTitle(
                context.tr("suggested_places"),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return gridItem(
                        context,
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/All_Gizah_Pyramids.jpg/435px-All_Gizah_Pyramids.jpg",
                        "Product ${index + 1}",
                        "subhead");
                  },
                ),
              ),
              TextTitle(
                context.tr("popular_places"),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    gridItem(
                      context,
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/All_Gizah_Pyramids.jpg/435px-All_Gizah_Pyramids.jpg",
                      "Product 1",
                      "subhead",
                    ),
                    gridItem(
                      context,
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/All_Gizah_Pyramids.jpg/435px-All_Gizah_Pyramids.jpg",
                      "Product 2",
                      "subhead",
                    ),
                    gridItem(
                      context,
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/All_Gizah_Pyramids.jpg/435px-All_Gizah_Pyramids.jpg",
                      "Product 3",
                      "subhead",
                    ),
                    gridItem(
                      context,
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/All_Gizah_Pyramids.jpg/435px-All_Gizah_Pyramids.jpg",
                      "Product 4",
                      "subhead",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
