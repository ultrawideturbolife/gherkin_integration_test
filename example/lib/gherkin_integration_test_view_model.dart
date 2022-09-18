import 'package:flutter/foundation.dart';
import 'package:veto/base_view_model.dart';

class GherkinIntegrationTestViewModel extends BaseViewModel {
  final String description =
      'You have pushed the button this many times\n(this does not test anything):';

  GherkinIntegrationTestViewModel();

  final String title = 'Gherkin Integration Test App';

  int modelCounter = 0;

  final ValueNotifier<int> _valueNotifierCounter = ValueNotifier(0);
  ValueListenable<int> get valueListenableCounter => _valueNotifierCounter;

  @override
  Future<void> initialise({arguments}) async {
    super.initialise();
  }

  @override
  void dispose() {
    _valueNotifierCounter.dispose();
    super.dispose();
  }

  /// Increments the [modelCounter], and then rebuilds the UI
  void incrementModelCounter() {
    modelCounter++;
    rebuild();
  }

  /// If the [modelCounter] is greater than 0, decrement the [modelCounter] and rebuild the UI
  void decrementModelCounter() {
    if (modelCounter > 0) {
      modelCounter--;
      rebuild();
    }
  }

  /// Increments the value of the [_valueNotifierCounter] by one
  void incrementValueNotifierCounter() => _valueNotifierCounter.value++;

  /// If the value of the [_valueNotifierCounter] is greater than 0 decrement the counter
  void decrementValueNotifierCounter() {
    if (_valueNotifierCounter.value > 0) {
      _valueNotifierCounter.value--;
    }
  }

  void reset() {
    _valueNotifierCounter.value = 0;
    modelCounter = 0;
    rebuild();
  }

  static GherkinIntegrationTestViewModel get locate =>
      GherkinIntegrationTestViewModel();
}
