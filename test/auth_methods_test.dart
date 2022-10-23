import 'package:flutter/lib/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('go to the list and detail views', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('Sample Items'), findsOneWidget);
      expect(find.textContaining('SampleItem'), findsNWidgets(3));

      final Finder sampleItem = find.text('SampleItem 1');

      await tester.tap(sampleItem);

      await tester.pumpAndSettle();

      expect(find.text('Item Details'), findsOneWidget);
    });
  });
}