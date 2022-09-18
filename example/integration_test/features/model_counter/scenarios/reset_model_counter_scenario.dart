import 'package:example/const_keys.dart';
import 'package:example/const_tooltips.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin_integration_test/integration_test.dart';

class ResetModelCounterScenario extends IntegrationScenario {
  ResetModelCounterScenario()
      : super(
          description: 'Reset the modelCounter',
          examples: [
            const IntegrationExample(values: [1]),
            const IntegrationExample(values: [3]),
          ],
          steps: [
            Given(
              'The GherkinIntegrationTestView is active',
              (tester, log, [example, binding, result]) async {
                log.info('Starting app..');
                await tester.pumpWidget(const MyApp());
                await tester.pumpAndSettle();
                log.success('App started!');
              },
            ),
            Given(
              'The modelCounter has been incremented',
              (tester, log, [example, binding, result]) async {
                final int initialValue = example.firstValue();
                log.info('Incrementing modelCounter with $initialValue..');
                final incrementButton =
                    find.byTooltip(ConstTooltips.incrementModelCounter);
                expect(incrementButton, findsOneWidget);
                for (int increment = 0; increment < initialValue; increment++) {
                  await tester.tap(incrementButton);
                  await tester.pumpAndSettle();
                }
                log.success('modelCounter incremented!');
              },
            ),
            WhenThen(
              'I call the reset method then the modelCounter should be 0',
              (tester, log, [example, binding, result]) async {
                log.info('Tapping reset button..');
                final resetButton = find.byKey(ConstKeys.resetButton);
                await tester.tap(resetButton);
                await tester.pumpAndSettle();
                expect(resetButton, findsOneWidget);
                final valueCounterValue = (find
                        .byKey(ConstKeys.valueOfTheModelCounter)
                        .evaluate()
                        .single
                        .widget as Text)
                    .data;
                expect(valueCounterValue, '0');
              },
            ),
          ],
        );
}
