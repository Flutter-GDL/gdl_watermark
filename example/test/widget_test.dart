// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';
import 'package:glob/glob.dart';


void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  /// NOTA NO FUNCIONA DESDE EL IDE USAR EL SIGUIENTE COMMANDO
  /// DESDE LA TERMINAL:
  ///
  /// https://github.com/flutter/flutter/issues/12999
  ///
  ///  flutter test --no-test-assets --plain-name "Sample de Paquete de gdl_watermark" test/widget_test.dart

  testWidgets('Sample de Paquete de gdl_watermark',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // verificar si el widget basico de texto existe
    expect(find.text('Hello Everybody!'), findsOneWidget);
  });
}
