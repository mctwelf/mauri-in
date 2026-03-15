import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mauri_in/features/search/presentation/search_screen.dart';
import 'package:mauri_in/features/auth/presentation/phone_auth_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Test SearchScreen for exceptions', (WidgetTester tester) async {
    FlutterError.onError = (FlutterErrorDetails details) {
      print('CAUGHT EXCEPTION: ${details.exception}');
      print('STACK: ${details.stack}');
    };

    try {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: SearchScreen(),
          ),
        ),
      );
      print('SearchScreen rendered successfully.');
    } catch (e, st) {
      print('CAUGHT EXCEPTION IN TRY-CATCH: $e');
      print('STACK: $st');
    }
  });

  testWidgets('Test PhoneAuthScreen for exceptions', (WidgetTester tester) async {
    FlutterError.onError = (FlutterErrorDetails details) {
      print('CAUGHT EXCEPTION: ${details.exception}');
      print('STACK: ${details.stack}');
    };

    try {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: PhoneAuthScreen(),
          ),
        ),
      );
      print('PhoneAuthScreen rendered successfully.');
    } catch (e, st) {
      print('CAUGHT EXCEPTION IN TRY-CATCH: $e');
      print('STACK: $st');
    }
  });
}
