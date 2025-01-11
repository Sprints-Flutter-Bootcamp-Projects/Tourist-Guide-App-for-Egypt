import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/data/home_data.dart';
import 'package:tourist_guide/widgets/lang_dialog.dart';
import 'package:tourist_guide/widgets/text_title.dart';

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
              flex: 7,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: gridItems.length,
                itemBuilder: (context, index) {
                  return gridItems[index];
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: gridItems.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [gridItems[index]],
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
