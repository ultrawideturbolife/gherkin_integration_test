part of 'integration_test.dart';

/// Callback used to provide the necessary tools to execute an [IntegrationStep].
typedef IntegrationStepCallback<T extends IntegrationExample?>
    = FutureOr<dynamic> Function(
  WidgetTester tester,
  IntegrationLog log, [
  T? example,
  IntegrationTestWidgetsFlutterBinding? binding,
  Object? result,
]);

/// Used to represents a step inside a [IntegrationScenario].
abstract class IntegrationStep<Example extends IntegrationExample?> {
  IntegrationStep({
    required String description,
    required IntegrationStepCallback<Example> step,
  })  : _description = description,
        _step = step;

  /// High-level description of the [IntegrationStep].
  final String _description;

  /// Async callback function that provides a [WidgetTester] and possible one of [IntegrationScenario._examples].
  final IntegrationStepCallback<Example?> _step;

  /// Runs all code defined in a specific [IntegrationStep].
  FutureOr<Object?> test({
    required WidgetTester tester,
    required IntegrationLog log,
    Example? example,
    IntegrationTestWidgetsFlutterBinding? binding,
    Object? result,
  }) async =>
      await tester.runAsync<Object?>(
        () async {
          debugPrintSynchronously(_description);
          return await _step(
            tester,
            log,
            example,
            binding,
            result,
          );
        },
      );
}

/// Implementation of a [IntegrationStep] that logs a 'Gherkin' -> 'Given' step.
class Given<Example extends IntegrationExample?>
    extends IntegrationStep<Example> {
  Given(String description, IntegrationStepCallback<Example> step)
      : super(
          description: '${IntegrationLog.tag} 👉 Given: $description',
          step: step,
        );
}

/// Implementation of a [IntegrationStep] that logs a 'Gherkin' -> 'And' step.
class And<Example extends IntegrationExample?>
    extends IntegrationStep<Example> {
  And(String description, IntegrationStepCallback<Example> step)
      : super(
          description: '${IntegrationLog.tag} 👉 And: $description',
          step: step,
        );
}

/// Implementation of an [IntegrationStep] that logs a 'Gherkin' -> 'When' step.
class When<Example extends IntegrationExample?>
    extends IntegrationStep<Example> {
  When(String description, IntegrationStepCallback<Example> step)
      : super(
          description: '${IntegrationLog.tag} 👉 When: $description',
          step: step,
        );
}

/// Implementation of an [IntegrationStep] that logs a 'Gherkin' -> 'Then' step.
class Then<Example extends IntegrationExample?>
    extends IntegrationStep<Example> {
  Then(String description, IntegrationStepCallback<Example> step)
      : super(
          description: '${IntegrationLog.tag} 👉 Then: $description',
          step: step,
        );
}

/// Implementation of an [IntegrationStep] that logs a 'Gherkin' -> 'But' step.
class But<Example extends IntegrationExample?>
    extends IntegrationStep<Example> {
  But(String description, IntegrationStepCallback<Example> step)
      : super(
          description: '${IntegrationLog.tag} 👉 But: $description',
          step: step,
        );
}

/// Implementation of an [IntegrationStep] that logs a 'Gherkin' -> 'Give', 'When' and 'Then' step.
class GivenWhenThen<Example extends IntegrationExample?>
    extends IntegrationStep<Example> {
  GivenWhenThen(String description, IntegrationStepCallback<Example> step)
      : super(
          description:
              '${IntegrationLog.tag} 👉 Give, When and Then: $description',
          step: step,
        );
}

/// Implementation of an [IntegrationStep] that logs a 'Gherkin' -> 'When' and 'Then' step.
class WhenThen<Example extends IntegrationExample?>
    extends IntegrationStep<Example> {
  WhenThen(String description, IntegrationStepCallback<Example> step)
      : super(
          description: '${IntegrationLog.tag} 👉 When and Then: $description',
          step: step,
        );
}

/// Implementation of an [IntegrationStep] that discards the 'Gherkin' notation and tells us directly what the code should do.
class Should<Example extends IntegrationExample?>
    extends IntegrationStep<Example> {
  Should(String description, IntegrationStepCallback<Example> step)
      : super(
          description: '${IntegrationLog.tag} 👉 Should: $description',
          step: step,
        );
}

/// Helpful but dangerous casting method to allow for easier usage of a [IntegrationStep] result.
///
/// This will cast the result to any type, use with caution!
extension StepResultExtension on Object? {
  E asType<E>() => this as E;
  E? asNullableType<E>() => this as E?;
}
