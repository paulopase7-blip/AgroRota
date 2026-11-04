import 'package:flutter_test/flutter_test.dart';
import 'package:agrorota/main.dart';

void main() {
  testWidgets('AgroRota abre o painel inicial', (tester) async {
    await tester.pumpWidget(const AgroRotaApp());

    expect(find.text('AgroRota'), findsOneWidget);
    expect(find.text('Calculadora de área'), findsOneWidget);
    expect(find.text('Planejar passadas'), findsOneWidget);
  });
}
