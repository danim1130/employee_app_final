import 'dart:io';

import 'package:employee_app/di/inject.dart';
import 'package:employee_app/ui/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test/integration_test_driver_extended.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  var binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized() as IntegrationTestWidgetsFlutterBinding;
  testWidgets('Test app start', (WidgetTester tester) async {
    await configureDependencies();
    await tester.pumpWidget(const MainApp());
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byType(FormBuilderTextField).first, 'dani@example.com');
    await tester.enterText(find.byType(FormBuilderTextField).last, '12');
    await tester.tap(find.byType(ElevatedButton));
    for(int i = 0; i < 4; i++){
      await Future.delayed(Duration(seconds: 1));
      await tester.pumpAndSettle();
    }
    await expectLater(
        find.byType(MaterialApp), matchesGoldenFile('login_page.png'));
    await binding.takeScreenshot('android_screenshot');
  });
}
