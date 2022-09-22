import 'package:flutter_test/flutter_test.dart';

class IntegrationLog {
  const IntegrationLog({
    required this.tester,
  });

  final WidgetTester tester;

  void info(String message) =>
      tester.printToConsole('[INTEGRATION-TEST] 🗣 $message');
  void value(Object? value, String message) =>
      tester.printToConsole('[INTEGRATION-TEST] 💾 $message: $value');
  void warning(String message) =>
      tester.printToConsole('[INTEGRATION-TEST] ⚠️ $message');
  void error(String message) =>
      tester.printToConsole('[INTEGRATION-TEST] ⛔️ $message');
  void success(String message) =>
      tester.printToConsole('[INTEGRATION-TEST] ✅️ $message');
}
