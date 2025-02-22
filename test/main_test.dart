// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tourist_guide/landing_page.dart';
import 'package:tourist_guide/views/government/government_page.dart';
import 'package:tourist_guide/views/home/favourites_page.dart';
import 'package:tourist_guide/views/home/home_page.dart';
import 'package:tourist_guide/views/profile/profile.dart';
import 'controllers_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //tests GovernorateController and PlacesController
  controllersTest();
  // testWidgets('MyNavigationBar renders correctly', (WidgetTester tester) async {
  //   await tester.pumpWidget(const MaterialApp(
  //     home: MyNavigationBar(),
  //   ));

  //   expect(find.byType(HomePage), findsOneWidget);
  //   expect(find.byType(GovernmentPage), findsNothing);
  //   expect(find.byType(FavouritesPage), findsNothing);
  //   expect(find.byType(Profile), findsNothing);

  //   await tester
  //       .tap(find.text('Governorates')); // Assuming 'Governorates' is the label
  //   await tester.pump();

  //   expect(find.byType(GovernmentPage), findsOneWidget);
  // });
}

// testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
