import 'package:flutter_test/flutter_test.dart';
import 'package:mauri_in/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('MauriIn app starts', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MauriInApp()),
    );
    // Verify splash screen renders
    expect(find.text('MauriIn'), findsOneWidget);
  });
}
