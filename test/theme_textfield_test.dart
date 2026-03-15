import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mauri_in/core/theme/app_theme.dart';

void main() {
  testWidgets('Test TextField with AppTheme directly', (WidgetTester tester) async {
    FlutterError.onError = (FlutterErrorDetails details) {
      print('CAUGHT EXCEPTION IN ONERROR: ${details.exception}');
      print('STACK: ${details.stack}');
    };

    try {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: TextField(
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Text('+222'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.orange, width: 1.5),
                ),
              ),
            ),
          ),
        ),
      );
      print('Isolated TextField rendered successfully with AppTheme.');
    } catch (e) {
      print('Isolated TextField crashed: $e');
    }
  });
}
