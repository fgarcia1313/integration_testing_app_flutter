import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_testing_app_flutter/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Flujo completo de login', (tester) async {
    // Arrange — abrir la app
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();

    // Act — llenar formulario
    await tester.enterText(find.byKey(Key('emailField')), 'user@mail.com');
    await tester.enterText(find.byKey(Key('passField')), '123456');

    // Presionar botón
    await tester.tap(find.byKey(Key('loginButton')));

    // Esperar que la navegación termine
    await tester.pumpAndSettle();

    // Assert — verificar que estamos en HomePage
    expect(find.text('Bienvenido'), findsOneWidget);
  });
}
