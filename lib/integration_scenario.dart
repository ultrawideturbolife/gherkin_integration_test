part of '../integration_test.dart';

/// Used to hold and test a list of [IntegrationStep].
class IntegrationScenario<Example extends IntegrationExample?> {
  IntegrationScenario({
    required String description,
    required List<IntegrationStep> steps,
    List<Example> examples = const [],
    IntegrationTestWidgetsFlutterBinding? binding,
    TestGroupFunction? setUpEach,
    TestGroupFunction? tearDownEach,
    TestGroupFunction? setUpOnce,
    TestGroupFunction? tearDownOnce,
  })  : _description = description,
        _steps = steps,
        _binding = binding,
        _examples = examples,
        _setUpEach = setUpEach,
        _tearDownEach = tearDownEach,
        _setUpOnce = setUpOnce,
        _tearDownOnce = tearDownOnce;

  /// Used to facilitate extra logging capabilities inside [IntegrationStep].
  IntegrationLog? _log;

  /// High-level description of the [IntegrationScenario].
  final String _description;

  /// List that specifies all [IntegrationScenario]s for a given [IGherkinFeature].
  ///
  /// For more information about how to write a [IntegrationStep] see the [IncrementCounterScenario]
  /// example or check out the [IntegrationStep] documentation.
  final List<IntegrationStep> _steps;

  /// List of scenario outline examples of type [Example] that extend [IntegrationExample].
  final List<Example> _examples;

  /// The glue between the widgets layer and the Flutter engine.
  final IntegrationTestWidgetsFlutterBinding? _binding;

  /// Code that will run at the START of this [IntegrationScenario]
  /// or at the START of EACH [IntegrationScenario._examples].
  final TestGroupFunction? _setUpEach;

  /// Code that will run ONCE at the END of this [IntegrationScenario]
  /// or ONCE at the END of EACH [IntegrationScenario._examples].
  final TestGroupFunction? _tearDownEach;

  /// Code that will run at the START of this [IntegrationScenario]
  /// regardless of how many [IntegrationScenario._examples] you have specified.
  final TestGroupFunction? _setUpOnce;

  /// Code that will run ONCE at the END of this [IntegrationScenario]
  /// regardless of how many [IntegrationScenario._examples] you have specified.
  final TestGroupFunction? _tearDownOnce;

  /// Runs all tests defined in this [IntegrationScenario]s [_steps].
  ///
  /// All tests run at least once (or more depending on the amount of examples) and inside their
  /// own [testWidgets] method. Override this method and call your [_steps] test() methods in a
  /// different manner if this unwanted behaviour.
  void test({IntegrationTestWidgetsFlutterBinding? binding}) {
    flutter_test.group(
      _description,
      () {
        _setUpAndTeardown();
        for (int index = 0; index < math.max(1, _examples.length); index++) {
          flutter_test.testWidgets(
            _examples.isNotEmpty
                ? 'Example ${index + 1}: ${_examples[index]}'
                : _description,
            (tester) async {
              try {
                if (_examples.isNotEmpty) {
                  final example = _examples[index];
                  debugPrint('🏷 Example ${index + 1}: $example');
                }
                debugPrint('🎬 Test started!');
                Object? result;
                for (final step in _steps) {
                  if (_examples.isNotEmpty) {
                    result = await step.test(
                      tester: tester,
                      log: _log ??= IntegrationLog(tester: tester),
                      example: _examples[index],
                      binding: _binding ?? binding,
                      result: result,
                    );
                    if (result != null) {
                      debugPrint('📜 Result:\n$result');
                    }
                  } else {
                    await step.test(
                      tester: tester,
                      binding: binding,
                      result: result,
                      log: _log ??= IntegrationLog(tester: tester),
                    );
                    if (result != null) {
                      debugPrint('📜 Result:\n$result');
                    }
                  }
                }
              } catch (error) {
                debugPrint('❌ Test failed!\n---');
                rethrow;
              }
            },
          );
        }
      },
    );
  }

  /// Runs any provided [_setUpEach], [_setUpOnce], [_tearDownEach] and [_tearDownOnce] methods.
  void _setUpAndTeardown() {
    if (_setUpOnce != null) flutter_test.setUpAll(_setUpOnce!);
    if (_tearDownOnce != null) flutter_test.tearDownAll(_tearDownOnce!);
    if (_setUpEach != null) flutter_test.setUp(_setUpEach!);
    if (_tearDownEach != null) flutter_test.tearDown(_tearDownEach!);
  }
}
