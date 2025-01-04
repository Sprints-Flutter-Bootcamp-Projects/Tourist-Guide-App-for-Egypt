import 'package:flutter/material.dart';
import 'package:tourist_guide/widgets/lang_dialog.dart';

PreferredSizeWidget? PagesAppBar(BuildContext context, String AppBarTitle) {
  return AppBar(
    centerTitle: true,
    title: Text(
      AppBarTitle,
      style: TextStyle(color: Colors.green),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.language, color: Colors.green),
        onPressed: () => langDialog(context),
      ),
    ],
  );
}
