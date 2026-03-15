import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test TextField for exceptions', (WidgetTester tester) async {
    FlutterError.onError = (FlutterErrorDetails details) {
      print('CAUGHT EXCEPTION: ${details.exception}');
      print('STACK: ${details.stack}');
    };

    try {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextField(
              keyboardType: TextInputType.phone,
              style: TextStyle(color: Colors.black, fontSize: 16),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Phone Number',
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Text('+222'),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
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
      print('TextField rendered successfully.');
    } catch (e, st) {
      print('CAUGHT EXCEPTION IN TRY-CATCH: $e');
      print('STACK: $st');
    }
  });
}
