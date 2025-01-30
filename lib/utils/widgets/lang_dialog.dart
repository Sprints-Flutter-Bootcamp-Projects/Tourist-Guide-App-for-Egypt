import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void langDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.tr("select_language")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  context.setLocale(const Locale('ar'));
                  Navigator.pop(context);
                },
                child: Text(tr("language_arabic")),
              ),
              TextButton(
                onPressed: () {
                  context.setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
                child: Text(tr("language_english")),
              )
            ],
          ),
        );
      });
}
