// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:gherkin_integration_test/integration_test.dart';

import 'features/model_counter/scenarios/decrement_model_counter_scenario.dart';
import 'features/model_counter/scenarios/decrement_value_notifier_counter_scenario.dart';
import 'features/model_counter/scenarios/increment_model_counter_scenario.dart';
import 'features/model_counter/scenarios/increment_value_notifier_counter_scenario.dart';
import 'features/model_counter/scenarios/reset_model_counter_scenario.dart';
import 'features/model_counter/scenarios/reset_value_notifier_counter_scenario.dart';

void main() {
  IntegrationTest(
    description:
        'An integration test to integration test the integration test example project',
    features: [
      IntegrationFeature(
        description: 'Model counter',
        scenarios: [
          IncrementModelCounterScenario(),
          DecrementModelCounterScenario(),
          ResetModelCounterScenario(),
        ],
      ),
      IntegrationFeature(
        description: 'ValueNotifier counter',
        scenarios: [
          IncrementValueNotifierCounterScenario(),
          DecrementValueNotifierCounterScenario(),
          ResetValueNotifierCounterScenario(),
        ],
      ),
    ],
  ).test();
}
