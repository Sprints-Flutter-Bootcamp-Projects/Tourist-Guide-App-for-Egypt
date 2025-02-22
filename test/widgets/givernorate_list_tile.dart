import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tourist_guide/utils/widgets/governorate_list_tile.dart';


void main() {
  testWidgets('GovernorateListTile displays correct name and icons', (WidgetTester tester) async {
    const testGovernorateName = "Cairo";

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GovernorateListTile(goverorateName: testGovernorateName),
        ),
      ),
    );

    // Check if the governorate name is displayed
    expect(find.text(testGovernorateName), findsOneWidget);

    // Check for the presence of icons
    expect(find.byIcon(Icons.pin_drop), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsOneWidget);
  });

  testWidgets('GovernorateListTile calls onTap when tapped', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GovernorateListTile(
            goverorateName: "Alexandria",
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    // Tap the list tile
    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();

    // Verify onTap was called
    expect(tapped, isTrue);
  });
}
