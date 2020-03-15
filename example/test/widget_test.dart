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

// A simple implementation of [AssetBundle] that reads files from an asset dir.
///
/// This is meant to be similar to the default [rootBundle] for testing.
class DiskAssetBundle extends CachingAssetBundle {
  static const _assetManifestDotJson = 'AssetManifest.json';

  /// Creates a [DiskAssetBundle] by loading [globs] of assets under `assets/`.
  static Future<AssetBundle> loadGlob(
    Iterable<String> globs, {
    String from = 'packages/gdl_watermark/assets/',
  }) async {
    final cache = <String, ByteData>{};
    for (final pattern in globs) {
      await for (final path in Glob(pattern).list(root: from)) {
        if (path is File) {
//          final bytes = await path.readAsBytes() as Uint8List;
          final bytes = await path.readAsBytes();
          cache[path.path] = ByteData.view(bytes.buffer);
        }
      }
    }
    final manifest = <String, List<String>>{};
    cache.forEach((key, _) {
      manifest[key] = [key];
    });

    cache[_assetManifestDotJson] = ByteData.view(
      Uint8List.fromList(jsonEncode(manifest).codeUnits).buffer,
    );

    return DiskAssetBundle._(cache);
  }

  final Map<String, ByteData> _cache;

  DiskAssetBundle._(this._cache);

  @override
  Future<ByteData> load(String key) async {
    return _cache[key];
  }
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  // esto es solo un ejemplo
  //flutter test --no-test-assets --plain-name "Verificar integridad de vista" test/widget_test.dart
  testWidgets('View Test', (WidgetTester tester) async {
    final assetBundle = await tester.runAsync(
      () =>
          DiskAssetBundle.loadGlob(['*.png']),
    );

    // Build our app and trigger a frame.
//    tester.pumpWidget(
//      DefaultAssetBundle(
//        bundle: assetBundle,
//        child: MyApp(),
//      ),
//    );
    await tester.pumpWidget(MyApp());
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('Sample de Paquete de gdl_watermark',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // verificar si el widget basico de texto existe
    expect(find.text('Hello Everybody!'), findsOneWidget);
  });
}
