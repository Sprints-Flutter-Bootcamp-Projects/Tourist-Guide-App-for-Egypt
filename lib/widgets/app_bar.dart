import 'package:flutter/material.dart';
import 'package:tourist_guide/widgets/lang_dialog.dart';

PreferredSizeWidget? PagesAppBar(BuildContext context, String AppBarTitle) {
  return AppBar(
    iconTheme:IconThemeData(color: Colors.teal[900]) ,
    backgroundColor: Colors.white,
    shadowColor: Colors.grey[100],
    elevation: 1,
    centerTitle: true,
    title: Text(
      AppBarTitle,
      style: TextStyle(color: Colors.teal[900]),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.language),
        onPressed: () => langDialog(context),
      ),
    ],
  );
}
