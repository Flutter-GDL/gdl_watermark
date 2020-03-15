
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gdl_watermark/gdl_watermark.dart';


/// Nota
///
/// muchas de estas pruebas de widgets son inútiles y medio tontas
/// https://geometrian.com/programming/tutorials/testing/test-first.php
///
/// solo estan para mostrar ejemplos de como crear pruebas
/// debes de siempre preguntarte:
///
///  La prueba que hago muestra evidencias de transformacion,
///    o solo confirma una constante?" (la segunda es perdida de tiempo)
///
///  Estoy probando algo que esta garantizado que funcione por el lenguaje?
///  (si la respuesta es si, pierdes tu tiempo)
///
///  Estoy probando comportamiento derivado de otro widget?
///  (si la respuesta es si, pierdes tu tiempo)
///
///  Estoy probando comportamiendo CAUSADO por otro widget?
///  esto si pruebalo!
///
/// poco a poco se mejorara esto...
///

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('finds only column no parent containers',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlutterGdl.showBottomWatermark(),
        ),
      ),
    );

    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Expanded), findsNothing);
    expect(find.byType(Flexible), findsNothing);
  });

  testWidgets('watermark_first_text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlutterGdl.showBottomWatermark(),
        ),
      ),
    );

    expect(find.text("Created with"), findsOneWidget);
  });

  testWidgets('watermark_find_image', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlutterGdl.showBottomWatermark(),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('no bottom', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlutterGdl.showBottomWatermark(bottomPadding: false),
        ),
      ),
    );

    expect(find.byType(SizedBox), findsNothing);
  });

  testWidgets('bottom margin', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlutterGdl.showBottomWatermark(bottomPadding: true),
        ),
      ),
    );

    expect(find.byType(SizedBox), findsOneWidget);
  });

  testWidgets('finds only expanded', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Column(
            children: <Widget>[
              FlutterGdl.showBottomWatermark(
                  containerType: ContainerType.expanded),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(Expanded), findsOneWidget);
    expect(find.byType(Flexible), findsNothing);
  });

  testWidgets('finds only flexible', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Column(
            children: <Widget>[
              FlutterGdl.showBottomWatermark(
                  containerType: ContainerType.flexible),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(Expanded), findsNothing);
    expect(find.byType(Flexible), findsOneWidget);
  });

  testWidgets('finds image asset', (WidgetTester tester) async {

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Column(
            children: <Widget>[
              Image.asset(
                "assets/corazon.png",
              ),
              Image.asset(
                "assets/mexico.png",
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(Image), findsNWidgets(2));
  });

  testWidgets('watermark_second_text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlutterGdl.showBottomWatermark(),
        ),
      ),
    );

    expect(find.text("for Flutter Guadalajara"), findsOneWidget);
  });
}
