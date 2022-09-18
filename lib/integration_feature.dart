part of '../integration_test.dart';

/// Used to specify and test a list of [IntegrationScenario].
class IntegrationFeature {
  const IntegrationFeature({
    required String description,
    required List<IntegrationScenario> scenarios,
    TestGroupFunction? setUpEach,
    TestGroupFunction? tearDownEach,
    TestGroupFunction? setUpOnce,
    TestGroupFunction? tearDownOnce,
    IntegrationTestWidgetsFlutterBinding? binding,
  })  : _description = description,
        _scenarios = scenarios,
        _setUpEach = setUpEach,
        _tearDownEach = tearDownEach,
        _setUpOnce = setUpOnce,
        _tearDownOnce = tearDownOnce,
        _binding = binding;

  /// High-level description of the [IntegrationFeature] and related [IntegrationScenario]s.
  final String _description;

  /// List that specifies all [IntegrationScenario]s for a given [IntegrationFeature].
  final List<IntegrationScenario> _scenarios;

  /// Code that will run at the START of each [IntegrationScenario] under this [IntegrationFeature]
  /// or at the START of EACH [IntegrationScenario._examples] under this [IntegrationFeature].
  final TestGroupFunction? _setUpEach;

  /// Code that will run ONCE at the END of this [IntegrationScenario] under this [IntegrationFeature]
  /// or ONCE at the END of EACH [IntegrationScenario._examples] under this [IntegrationFeature].
  final TestGroupFunction? _tearDownEach;

  /// Code that will be run ONCE at the START of this [IntegrationFeature].
  final TestGroupFunction? _setUpOnce;

  /// Code that will be run ONCE at the END of this [IntegrationFeature].
  final TestGroupFunction? _tearDownOnce;

  /// The glue between the widgets layer and the Flutter engine.
  final IntegrationTestWidgetsFlutterBinding? _binding;

  /// Runs this [IntegrationFeature]'s [IntegrationScenario.test] methods.
  void test({
    IntegrationTestWidgetsFlutterBinding? binding,
    String? testDescription,
    int? nrFeature,
  }) {
    flutter_test.group(
      _description,
      () {
        _setUpAndTeardown();
        for (int nrScenario = 0; nrScenario < _scenarios.length; nrScenario++) {
          _scenarios[nrScenario].test(
            binding: _binding ?? binding,
            featureDescription: _description,
            testDescription: testDescription,
            nrScenario: nrScenario,
            nrFeature: nrFeature,
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
