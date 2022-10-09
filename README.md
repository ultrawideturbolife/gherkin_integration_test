# 🦾 **Gherkin Integration Test**

---

<aside>
❗  The example project has a test folder where the example project is being fully tested with this framework.

</aside>

This package is based on the `Behaviour Driven Development` (BDD) language called `Gherkin`. This language enables us as developers to design and execute tests in an intuitive and readable way. For people who have a little less experience with development, these tests are also easy to understand because the syntax is very similar to English.

![DALL·E 2022-09-27 21.08.11 - a gherkin monster super hero with wings and a computer flying through space, fantasy style.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/262db4dd-7e50-4de6-a798-0447ecd3ec92/DALLE_2022-09-27_21.08.11_-_a_gherkin_monster_super_hero_with_wings_and_a_computer_flying_through_space_fantasy_style.png)

Most tests look something like this:

```gherkin
Feature: This feature shows an example

    Scenario: It shows a good example
      Given we start without an example
      When an example gets created
      Then the example should explode
```

In this same way we have built our framework, we have the following classes at our disposal:

- `IntegrationTest`
- `IntegrationFeature`
- `IntegrationScenario`
- `IntegrationExample`
- `IntegrationStep` (abstract)
  - `Given`
  - `When`
  - `Then`
  - `And`
  - `But`

From top to bottom, each class may contain a number of the class below it (one to many). A `IntegrationTest` may contain multiple `IntegrationFeature` which in turn may contain multiple `IntegrationScenario` which in turn may contain multiple `IntegrationExample` and `IntegrationStep`.

## **🛠 Implementation**

---

Start by creating a test class that inherits the `IntegrationTest` class. Then create a constructor that takes no arguments but does call the superclass with a `description` and (for now) an empty list of `features`.

```dart
class DummyIntegrationTest extends IntegrationTest {
  DummyIntegrationTest()
      : super(
          description: 'All integration tests regarding dummies',
          features: [],
        );
}
```

### **📲 Features**

---

In the `features` list we can now define our first `IntegrationFeature`. We give it a name and (for now) an empty list of `scenarios`.

```dart
class DummyIntegrationTest extends IntegrationTest {
  DummyIntegrationTest()
      : super(
          description: 'All integration tests regarding dummies',
          features: [
            IntegrationFeature(
              description: 'Saving of dummies',
              scenarios: [],
            ),
          ],
        );
}
```

### **🤝 Scenarios**

---

Now it's time to think about what kind of `scenarios` might occur in your test. For this example we will use ’a successful save’ and ‘an unsuccessful save’ as possible `scenarios`.

We use the `IntegrationScenario` class to create both `scenarios` and place them in the empty list. We also pass in a `description` and this time an empty list of `steps`.

```dart
class DummyIntegrationTest extends IntegrationTest {
  DummyIntegrationTest()
      : super(
          description: 'All integration tests regarding dummies',
          features: [
            IntegrationFeature(
              description: 'Saving of dummies',
              scenarios: [
                IntegrationScenario(
                  description: 'Saving a good dummy should succeed',
                  steps: [],
                ),
                IntegrationScenario(
                  description: 'Saving a bad dummy should fail',
                  steps: [],
                ),
              ],
            ),
          ],
        );
}
```

### **🐾 Steps**

---

Now comes the good part. For each scenario, we may define `steps`. We have access to `Given`, `When`, `Then`, `And` and `But`. All of these steps do basically the same thing in the background, but by using them correctly, you learn to plan, work out and execute your tests in an intuitive and proper BDD way.

Each step requires a description and a callback. The callback for the `IntegrationTests` looks as follows and grants access to the following parameters:

```dart
/// Callback used to provide the necessary tools to execute an [IntegrationStep].
typedef IntegrationStepCallback<Example extends IntegrationExample?> = FutureOr<void> Function(
  WidgetTester tester,
  IntegrationLog log,
  IntegrationBox box,
  IntegrationMocks mocks, [
  Example? example,
  IntegrationTestWidgetsFlutterBinding? binding,
]);
```

- `WidgetTester tester`
  - Class that programmatically interacts with widgets and the test environment (directly from Flutter’s `integration_test` **package).
- `Log log`
  - Class that allows for subtle logging of steps information in your tests.
- `IntegrationBox box`
  - This box is basically a map that may be used to write and read values that need to persist throughout a series of steps inside a `IntegrationScenario`. Any value that you `box.write(key, value)` will be retrievable in all `IntegrationStep`'s after that or until removed or until all steps have been executed. Reading a value with box.`read(key)` will automatically cast it to the `Type` that you specify. So reading an `int` like this → `final int value = box.read(myIntValue)` would automatically cast it to an `int` (🆒).

    Using the box may look like this:

      ```dart
      [
        Given(
          'This is an example for the IntegrationBox',
          (tester, log, box, mocks, [example, binding]) {
            box.write('isExample', true);
          },
        ),
        When(
          'we write some values',
          (tester, log, box, mocks, [example, binding]) {
            box.write('exampleValue', 1);
            box.write('mood', 'happy');
          },
        ),
        Then(
          'all the values should be accessible up until the last step.',
          (tester, log, box, mocks, [example, binding]) {
            final bool isExample = box.read('isExample');
            final int exampleValue = box.read('exampleValue');
            final bool mood = box.read('mood');
            expect(isExample, true);
            expect(exampleValue, 1);
            expect(mood, 'happy');
          },
        ),
      ]
      ```

- `IntegrationMocks mocks`
  - A box that exists and persists throughout your entire `IntegrationTest`, `IntegrationFeature` and/or `IntegrationScenario`. You may have optionally use this box to store mocks that you need so you may later retrieve them to stub methods to your liking. You may set up your mocks from any method but it’s recommended to use the `setUpMocks` method because that runs before any other method inside any of the test classes and will allow you to keep a good overview.
- `IntegrationExample? example`
  - Optional ‘Scenario Outline’ examples that may have been specified inside a `IntegrationScenario` like this:

      ```dart
      IntegrationScenario(
        description: 'Saving a good dummy should succeed',
        examples: [
          const IntegrationExample(values: [1]),
          const IntegrationExample(values: [5]),
          const IntegrationExample(values: [10]),
        ],
      )
      ```

    This `IntegrationScenario` will now run 3 times, once for each `IntegrationExample`. You may access the `example` in the following way:

      ```dart
      Given(
          'I access the example value',
          (tester, log, box, mocks, [example, binding]) {
            final int exampleValue = example!.firstValue();
          },
        )
      ```

      <aside>
      💡 Be sure to make your declaration type safe so the `firstValue()` helper method can `cast` the value to whatever type your specify, use with caution!

      </aside>


### **🐾 Steps Implementation**

Combining all that information will allow us to finalise and set up the success scenario like this:

```dart
class DummyIntegrationTest extends IntegrationTest {
  DummyIntegrationTest()
      : super(
          description: 'All integration tests regarding dummies',
          features: [
            IntegrationFeature(
              description: 'Saving of dummies',
              setUpOnce: (mocks) {
                final dummyMock = DummyMock();
                mocks.write(dummyMock);
              },
              scenarios: [
                IntegrationScenario(
                  description: 'Saving a good dummy should succeed',
                  steps: [
                    Given(
                      'The dummy service is initialised',
                      (tester, log, box, mocks, [example, binding]) {
                        mocks.read(DummyMock).stubWhatever();
                        // TODO(you): Initialise service
                      },
                    ),
                    When(
                      'We call the dummy service with dummy info',
                      (tester, log, box, mocks, [example, binding]) {
                        // TODO(you): Call dummy service with dummy info
                      },
                    ),
                    Then(
                      'It should succeed',
                      (tester, log, box, mocks, [example, binding]) {
                        // TODO(you): Verify success
                      },
                    ),
                  ],
                ),
                IntegrationScenario(
                  description: 'Saving a bad dummy should fail',
                  steps: [],
                ),
              ],
            ),
          ],
        );
}
```

<aside>
💡 We have also added the usage of `mocks` in this example to demonstrate the `IntegrationMocks` feature. The `IntegrationFeature` now has a `setupOnce` method (more on this type of method later) that creates the mock and puts into the `mocks` object. We then later retrieve this mock in the `Given` step to `stub` it for a hypothetical reaction.

</aside>

### **🏆 Bonus IntegrationSteps**

---

Because not everybody wants to write tests the same way we also created these combined step classes to allow for creating the same kind of integration tests, but with less steps.

- `GivenWhenThen`
  - For when you can’t be bothered to create and use the separate step functionality regarding the ‘`Given`’, ‘`When`’ and ‘`Then`’ steps. This allows you to write the entire test in one step.
- `WhenThen`
  - For when you can’t be bothered to create and use the separate step functionality regarding the ‘`When`’ and ‘`Then`’ steps. This allows you to combine both steps into one.
- `Should`
  - For when you feel like using steps is not your style. This step defines the entire test in one ‘`Should`’ sentence.

# **⚡️ Almost there!**

While this may perfectly fit our testing needs there are a couple functionalities at our disposal that give our tests extra power.

### **🏗 setUpMocks, setUpOnce, setUpEach, tearDownOnce, tearDownEach**

---

Each class has access to these methods and will run them in sort of the same way:

- `setUpMocks` - will run first before any other method inside an `IntegrationTest`, `IntegrationFeature` or `IntegrationScenario`.
- `setUpEach` - will run at the START of EACH `IntegrationScenario` under the chosen class (may be specified in `IntegrationTest`, `IntegrationFeature` or `IntegrationScenario` itself).
- `tearDownEach` - will run at the END of EACH `IntegrationScenario` under the chosen class (may be specified in `IntegrationTest`, `IntegrationFeature` or `IntegrationScenario` itself).
- `setUpOnce` - will run ONCE at the START of chosen class (may be specified in `IntegrationTest`, `IntegrationFeature` or `IntegrationScenario` itself).
- `tearDownOnce` - will run ONCE at the END of chosen class (may be specified in `IntegrationTest`, `IntegrationFeature` or `IntegrationScenario` itself).

<aside>
💡 So a good way to remember which method does what is that all the `each` methods will run per `IntegrationScenario` / `IntegrationExample` (**this** is important to realise!) **under the defining class that holds the method** and all the `once` methods will run **once in the defining class that holds the method**.

</aside>

Using the methods may look a bit like this:

```dart
class DummyIntegrationTest extends IntegrationTest {
  DummyIntegrationTest()
      : super(
          description: 'All integration tests regarding dummies',
          features: [
            IntegrationFeature(
              description: 'Saving of dummies',
              setUpMocks: (mocks) {
                mocks.write(DummyMock());
              },
              setUpOnce: (mocks) {
                // Do something once
              },
              setUpEach: (mocks) async {
                AppSetup.reset();
              },
              tearDownOnce: (mocks) async {
                // Do something
              },
              scenarios: [
                IntegrationScenario(
                  description: 'Saving a good dummy should succeed',
                  steps: [
                    Given(
                      'The dummy service is initialised',
                      (tester, log, box, mocks, [example, binding]) {
                        mocks.read(DummyMock).stubWhatever();
                        // TODO(you): Initialise service
                      },
                    ),
                    When(
                      'We call the dummy service with dummy info',
                      (tester, log, box, mocks, [example, binding]) {
                        // TODO(you): Call dummy service with dummy info
                      },
                    ),
                    Then(
                      'It should succeed',
                      (tester, log, box, mocks, [example, binding]) {
                        // TODO(you): Verify success
                      },
                    ),
                  ],
                ),
                IntegrationScenario(
                  description: 'Saving a bad dummy should fail',
                  steps: [],
                ),
              ],
            ),
          ],
        );
}
```

Now to run these tests all you have to do is add the `DummyIntegrationTests` to your main test function and hit run. In this example we would like to use the `IntegrationTestWidgetsFlutterBinding` in our tests so let’s add that to the constructor as well.

```dart
// Adding it to the constructor
DummyIntegrationTest({required IntegrationTestWidgetsFlutterBinding binding})
      : super(
          description: 'All tests regarding dummies',
          binding: binding,

```

```dart
void main() {
// Getting the binding by calling this function
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;
// Running the test
  DummyIntegrationTests(binding: binding).test();
}

```
