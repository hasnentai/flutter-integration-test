import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:integration_test/integration_test.dart';
import 'package:login_test_cases/flutter_flow/flutter_flow_widgets.dart';
import 'package:login_test_cases/flutter_flow/flutter_flow_theme.dart';
import 'package:login_test_cases/index.dart';
import 'package:login_test_cases/main.dart';
import 'package:login_test_cases/flutter_flow/flutter_flow_util.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await FlutterFlowTheme.initialize();
  });

  group('Login Page', () {
    testWidgets('Test a Valid login flow', (WidgetTester tester) async {
      _overrideOnError();

      await tester.pumpWidget(const MyApp());
      await GoogleFonts.pendingFonts();

      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const ValueKey('emailText')), 'test@gmail.com');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const ValueKey('passwordText')), 'Hello World');
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('Button_mwws')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('dashboard1')), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets('Invalid Email and Password cannot be empty',
        (WidgetTester tester) async {
      _overrideOnError();

      await tester.pumpWidget(const MyApp());
      await GoogleFonts.pendingFonts();

      await tester.tap(find.byKey(const ValueKey('Button_mwws')));
      await tester.pumpAndSettle();
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
    });
  });
}

// There are certain types of errors that can happen during tests but
// should not break the test.
void _overrideOnError() {
  final originalOnError = FlutterError.onError!;
  FlutterError.onError = (errorDetails) {
    if (_shouldIgnoreError(errorDetails.toString())) {
      return;
    }
    originalOnError(errorDetails);
  };
}

bool _shouldIgnoreError(String error) {
  // It can fail to decode some SVGs - this should not break the test.
  if (error.contains('ImageCodecException')) {
    return true;
  }
  // Overflows happen all over the place,
  // but they should not break tests.
  if (error.contains('overflowed by')) {
    return true;
  }
  // Sometimes some images fail to load, it generally does not break the test.
  if (error.contains('No host specified in URI') ||
      error.contains('EXCEPTION CAUGHT BY IMAGE RESOURCE SERVICE')) {
    return true;
  }
  // These errors should be avoided, but they should not break the test.
  if (error.contains('setState() called after dispose()')) {
    return true;
  }
  // Web-specific error when interacting with TextInputType.emailAddress
  if (error.contains('setSelectionRange') &&
      error.contains('HTMLInputElement')) {
    return true;
  }

  return false;
}
