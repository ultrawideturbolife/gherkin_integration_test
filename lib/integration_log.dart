import 'package:flutter/foundation.dart';

class IntegrationLog {
  const IntegrationLog();

  static const String tag = '[INTEGRATION-TEST]';

  void info(String message) =>
      tester.printToConsole('[INTEGRATION-TEST] 🗣 $message');
  void value(Object? value, String message) =>
      debugPrintSynchronously('$tag 💾 $message: $value');
  void warning([String message = 'Warning!']) =>
      debugPrintSynchronously('$tag ⚠️ $message');
  void error([String message = 'Error!']) =>
      debugPrintSynchronously('$tag ⛔️ $message');
  void success([String message = 'Success!']) =>
      debugPrintSynchronously('$tag ✅️ $message');
}
