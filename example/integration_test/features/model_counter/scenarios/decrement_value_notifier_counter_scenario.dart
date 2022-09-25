import 'dart:math';

import 'package:example/const_keys.dart';
import 'package:example/const_tooltips.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin_integration_test/integration_test.dart';

class DecrementValueNotifierCounterScenario extends IntegrationScenario {
  static const _originalCounterValue = 3;
  DecrementValueNotifierCounterScenario()
      : super(
          description: 'Decrement the ValueNotifier',
          examples: [
            const IntegrationExample(values: [1]),
            const IntegrationExample(values: [5]),
            const IntegrationExample(values: [10]),
          ],
          steps: [
            Given(
              'The GherkinIntegrationTestView is active',
              (tester, log, box, [example, binding]) async {
                log.info('Initialising the view..');
                await tester.pumpWidget(const MyApp());
                await tester.pumpAndSettle();
                log.info('View initialised!..');
              },
            ),
            And(
              'The counter is at $_originalCounterValue',
              (tester, log, box, [example, binding]) async {
                log.info('Setting the counter to $_originalCounterValue..');
                final resetButton = find.byKey(ConstKeys.resetButton);
                expect(resetButton, findsOneWidget);
                await tester.tap(resetButton);
                await tester.pumpAndSettle();
                log.success(
                    'Reset button found and tapped! Finding increment button..');
                final incrementButton =
                    find.byTooltip(ConstTooltips.incrementValueNotifier);
                expect(incrementButton, findsOneWidget);
                log.success('Increment button found!');
                final value =
                    find.byKey(ConstKeys.valueOfTheValueNotifierCounter);
                expect((value.evaluate().single.widget as Text).data, '0');
                for (int x = 0; x < _originalCounterValue; x++) {
                  log.info(
                      'Increment button tapped! ${x + 1}/$_originalCounterValue');
                  await tester.tap(incrementButton);
                  await tester.pumpAndSettle();
                }
                expect(
                  (value.evaluate().single.widget as Text).data,
                  _originalCounterValue.toString(),
                );
                log.success('Counter set at $_originalCounterValue!');
              },
            ),
            When(
              'I decrement the counter',
              (tester, log, box, [example, binding]) async {
                final nrOfDecrements = example.firstValue();
                log.info('Decrementing the counter $nrOfDecrements times..');
                final button =
                    find.byTooltip(ConstTooltips.decrementValueNotifier);
                expect(button, findsOneWidget);
                log.success('Decrement button found!');
                for (int x = 0; x < nrOfDecrements; x++) {
                  log.info('Increment button tapped! ${x + 1}/$nrOfDecrements');
                  await tester.tap(button);
                  await tester.pumpAndSettle();
                }
                log.success('Counter decremented!');
              },
            ),
            Then(
              'We expect the ValueNotifier to have a '
              'decremented value of ($_originalCounterValue minus decrements) '
              'and (at least 0)',
              (tester, log, box, [example, binding]) async {
                log.info('Checking value of counter..');
                final counterValue = (find
                        .byKey(ConstKeys.valueOfTheValueNotifierCounter)
                        .evaluate()
                        .single
                        .widget as Text)
                    .data;
                expect(
                  counterValue,
                  max(_originalCounterValue - example.firstValue(), 0)
                      .toString(),
                );
                log.success('Counter was $counterValue!');
              },
            ),
          ],
        );
}
