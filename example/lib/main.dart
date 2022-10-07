import 'package:example/gherkin_integration_test_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin_integration_test/integration_test.dart';

import 'const_keys.dart';
import 'const_tooltips.dart';

void main() {
  runApp(const MyApp());
}

/// Just here to showcase the package.
///
/// Example project /integration_test has all type of tests that fully tests the example project.
class IncrementModelCounterScenario extends IntegrationScenario {
  IncrementModelCounterScenario()
      : super(
          description: 'Increment the modelCounter',
          examples: [
            const IntegrationExample(values: [1]),
            const IntegrationExample(values: [5]),
            const IntegrationExample(values: [10]),
          ],
          steps: [
            Given(
              'The GherkinIntegrationTestView is active',
              (tester, log, box, mocks, [example, binding]) async {
                log.info('Initialising the view..');
                await tester.pumpWidget(const MyApp());
                await tester.pumpAndSettle();
                log.info('View initialised!..');
              },
            ),
            When(
              'I increment the counter',
              (tester, log, box, mocks, [example, binding]) async {
                log.info('Setting the counter to 0, finding reset button..');
                final resetButton = find.byKey(ConstKeys.resetButton);
                expect(resetButton, findsOneWidget);
                await tester.tap(resetButton);
                await tester.pumpAndSettle();
                log.success(
                    'Reset button found and tapped! Finding increment button..');
                final button =
                    find.byTooltip(ConstTooltips.incrementModelCounter);
                expect(button, findsOneWidget);
                log.success('Increment button found!');
                final nrOfDecrements = example.firstValue();
                for (int x = 0; x < nrOfDecrements; x++) {
                  log.info('Increment button tapped! ${x + 1}/$nrOfDecrements');
                  await tester.tap(button);
                  await tester.pumpAndSettle();
                }
                log.success('Counter incremented!');
              },
            ),
            Then(
              'We expect the modelCounter to have the value of the increments',
              (tester, log, box, mocks, [example, binding]) async {
                log.info('Finding value counter value..');
                final valueCounterValue = (find
                        .byKey(ConstKeys.valueOfTheModelCounter)
                        .evaluate()
                        .single
                        .widget as Text)
                    .data;
                log.success('Value counter value found! ($valueCounterValue)');
                expect(valueCounterValue, example.firstValue().toString());
              },
            ),
          ],
        );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gherkin Integration Test',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const GherkinIntegrationTestView(),
    );
  }
}
