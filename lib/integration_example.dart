part of '../integration_test.dart';

/// Used to define 'Scenario Outline' examples.
class IntegrationExample {
  const IntegrationExample({
    List<Object?>? values,
    String? description,
    this.isLastExample = false,
  })  : _values = values,
        _description = description;

  /// May be used to specify example values in a non typesafe manner.
  final List<Object?>? _values;

  /// Optional description for improved logging.
  final String? _description;

  /// Indicates whether this is the last example of a scenario.
  final bool isLastExample;

  @override
  String toString() => _description ?? 'IntegrationExample{values: $_values}';
}

extension IntegrationExampleExtension on IntegrationExample? {
  /// Get all the non typesafe values.
  ///
  /// Trusts user that [IntegrationExample] and [values] is not null, use with caution.
  List<Object?> get values => this!._values!;

  /// Gets value at [index] of [values].
  ///
  /// Trusts user that value at [index] is not null, use with caution.
  T value<T>([int index = 0]) => values[index] as T;

  /// Syntax sugar for grabbing the first value.
  T firstValue<T>() => value<T>(0);

  /// Syntax sugar for grabbing the second value.
  T secondValue<T>() => value<T>(1);

  /// Syntax sugar for grabbing the third value.
  T thirdValue<T>() => value<T>(2);

  /// Syntax sugar for grabbing the fourth value.
  T fourthValue<T>() => value<T>(3);

  /// Syntax sugar for grabbing the fifth value.
  T fifthValue<T>() => value<T>(4);

  /// Syntax sugar for grabbing the sixth value.
  T sixthValue<T>() => value<T>(5);

  /// Syntax sugar for grabbing the seventh value.
  T seventhValue<T>() => value<T>(6);

  /// Syntax sugar for grabbing the eight value.
  T eightValue<T>() => value<T>(7);

  /// Syntax sugar for grabbing the ninth value.
  T ninthValue<T>() => value<T>(8);

  /// Syntax sugar for grabbing the tenth value.
  T tenthValue<T>() => value<T>(9);
}
