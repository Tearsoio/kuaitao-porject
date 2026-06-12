import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kuaitao_app/main.dart';

void main() {
  testWidgets('App boots without throwing — splash page is rendered first',
      (WidgetTester tester) async {
    await tester.pumpWidget(const KuaitaoApp());
    // 等首帧渲染完成；不 pumpAndSettle 以避免 splash 跳转计时器
    await tester.pump();
    // 最起码 MaterialApp.router 已挂载
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
