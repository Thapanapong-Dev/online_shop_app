import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_shop_app/view/saved/kampoo.dart';

void main() {
  testWidgets('kampoo ...', (tester) async {
    await tester.runAsync(
      () async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(home: const Kampoo()),
          ),
        );
        await tester.pump();
      },
    );
    // Verify that our counter starts at 0.
    expect(find.text('kampoo'), findsOneWidget);
  });
}
