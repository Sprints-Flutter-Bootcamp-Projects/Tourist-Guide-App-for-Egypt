import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/widgets/lang_dialog.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              Expanded(
                child: TextTitle(
                  context.tr("suggested_places"),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.language,
                  color: Colors.teal[900],
                ),
                onPressed: () => langDialog(context),
              ),
            ]),
            Expanded(
              flex: 8,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GridItem(
                    context,
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/All_Gizah_Pyramids.jpg/435px-All_Gizah_Pyramids.jpg",
                    "Product ${index + 1}",
                    "subhead",
                  );
                },
              ),
            ),
            Divider(
              thickness: 1.2,
              //height: ,
              color: Colors.teal[300],
            ),
            TextTitle(
              context.tr("popular_places"),
            ),
            Expanded(
              flex: 3,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  GridItem(
                    context,
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/All_Gizah_Pyramids.jpg/435px-All_Gizah_Pyramids.jpg",
                    "Product 1",
                    "subhead",
                  ),
                  GridItem(
                    context,
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/All_Gizah_Pyramids.jpg/435px-All_Gizah_Pyramids.jpg",
                    "Product 2",
                    "subhead",
                  ),
                  GridItem(
                    context,
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/All_Gizah_Pyramids.jpg/435px-All_Gizah_Pyramids.jpg",
                    "Product 3",
                    "subhead",
                  ),
                  GridItem(
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
    );
  }
}
