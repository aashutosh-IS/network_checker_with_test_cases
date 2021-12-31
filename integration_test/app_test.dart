import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:the_logistic_mall/listing_screen.dart';

import 'package:the_logistic_mall/main.dart' as app;
import 'package:the_logistic_mall/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Find Textfield and then enter some values', () {
    testWidgets('Tap on Textfield', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Finds the textfield  to tap on.
      final Finder textfield = find.byKey(const ValueKey('textfield'));
      final Finder button = find.byKey(const ValueKey('elevBtn'));
      await tester.tap(textfield).then((_) async {
        await tester.enterText(textfield, 'This is my test text');
      });
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.tap(button);
    });
  });
}
// flutter test integration_test
// 