import 'package:example/const_keys.dart';
import 'package:example/const_tooltips.dart';
import 'package:example/main.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin_integration_test/integration_test.dart';

class ResetValueNotifierCounterScenario extends IntegrationScenario {
  ResetValueNotifierCounterScenario()
      : super(
          description: 'Reset the ValueNotifier',
          examples: [
            const IntegrationExample(values: [1]),
            const IntegrationExample(values: [3]),
          ],
          steps: [
            Given(
              'The GherkinIntegrationTestView is active',
              (tester, log, box, [example, binding]) async {
                await tester.pumpWidget(const MyApp());
                await tester.pumpAndSettle();
                log.success('App started!');
              },
            ),
            Given(
              'The ValueNotifier has been incremented',
              (tester, log, box, [example, binding]) async {
                final int initialValue = example.firstValue();
                log.info('Incrementing ValueNotifier with $initialValue..');
                final incrementButton =
                    find.byTooltip(ConstTooltips.incrementValueNotifier);
                expect(incrementButton, findsOneWidget);
                for (int increment = 0; increment < initialValue; increment++) {
                  await tester.tap(incrementButton);
                  await tester.pumpAndSettle();
                }
                log.success('ValueNotifier incremented!');
              },
            ),
            WhenThen(
              'I call the reset method then the ValueNotifier should be 0',
              (tester, log, box, [example, binding]) async {
                log.info('Tapping reset button..');
                final resetButton = find.byKey(ConstKeys.resetButton);
                await tester.tap(resetButton);
                await tester.pumpAndSettle();
                expect(resetButton, findsOneWidget);
                final valueCounterValue = (find
                        .byKey(ConstKeys.valueOfTheValueNotifierCounter)
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
