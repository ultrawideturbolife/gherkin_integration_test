import 'package:example/const_keys.dart';
import 'package:example/const_tooltips.dart';
import 'package:flutter/material.dart';
import 'package:veto/base_view_model.dart';

import 'gherkin_integration_test_view_model.dart';

class GherkinIntegrationTestView extends StatelessWidget {
  const GherkinIntegrationTestView({Key? key}) : super(key: key);
  static const String route = 'gherkin-unit-test-view';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GherkinIntegrationTestViewModel>(
      builder: (context, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(model.title),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 32),
                Text(
                  'Made by Viewer 1 and Me',
                  style: model.textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Image.asset('assets/example_image.jpg'),
                const SizedBox(height: 32),
                Text(model.description, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${model.modelCounter}',
                        key: ConstKeys.valueOfTheModelCounter,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      ValueListenableBuilder<int>(
                        valueListenable: model.valueListenableCounter,
                        builder: (context, valueListenableCounter, child) =>
                            Text(
                          valueListenableCounter.toString(),
                          key: ConstKeys.valueOfTheValueNotifierCounter,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        tooltip: ConstTooltips.incrementModelCounter,
                        onPressed: model.incrementModelCounter,
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.add),
                      ),
                      FloatingActionButton(
                        tooltip: ConstTooltips.incrementValueNotifier,
                        onPressed: model.incrementValueNotifierCounter,
                        backgroundColor: Colors.blue,
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    key: ConstKeys.resetButton,
                    onPressed: model.reset,
                    child: const Text('Reset'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        tooltip: ConstTooltips.decrementModelCounter,
                        onPressed: model.decrementModelCounter,
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.remove),
                      ),
                      FloatingActionButton(
                        tooltip: ConstTooltips.decrementValueNotifier,
                        onPressed: model.decrementValueNotifierCounter,
                        backgroundColor: Colors.blue,
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => GherkinIntegrationTestViewModel.locate,
    );
  }
}
