// Тест для додатку розкладу поїздів УЗ
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trainshedule/main.dart';

void main() {
  testWidgets('Smoke test - app loads correctly', (WidgetTester tester) async {
    // Встановлюємо розмір екрану для тесту
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    
    // Створюємо наш додаток
    await tester.pumpWidget(const TrainScheduleApp());
    await tester.pumpAndSettle();

    // Перевіряємо, що основні елементи інтерфейсу присутні
    expect(find.text('Розклад поїздів УЗ'), findsOneWidget);
    expect(find.text('Напрямок'), findsOneWidget);
    expect(find.text('Табло'), findsOneWidget);
    expect(find.text('Номер поїзда'), findsOneWidget);
  });
}
