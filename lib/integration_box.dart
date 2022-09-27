part of 'integration_test.dart';

/// Used to store data that stays persistent over several [IntegrationStep]s inside a [IntegrationScenario].
class IntegrationBox {
  late final Map<Object, Object?> _mapBox = {};

  /// Reads a value from the box based on [key].
  T read<T extends Object?>(Object key) {
    final value = _mapBox[key] as T;
    debugPrintSynchronously(
        '${IntegrationLog.tag} 📦 Reading \'$key\' value: $value as ${value.runtimeType} from the box!');
    return value;
  }

  /// Writes a value to the box based on [key] and [value]
  void write(Object key, Object? value) {
    _mapBox[key] = value;
    debugPrintSynchronously(
        '${IntegrationLog.tag} 📦 Writing \'$key\' value: $value as ${value.runtimeType} to the box!');
  }

  /// Deletes a value from the box based on [key].
  void delete(Object key) {
    final deletedValue = _mapBox.remove(key);
    debugPrintSynchronously(
        '${IntegrationLog.tag} 📦 Deleted \'$key\' deletedValue: $deletedValue as ${deletedValue.runtimeType} from the box!');
  }

  /// Clears all values of the [_mapBox].
  void clear() {
    debugPrintSynchronously(
        '${IntegrationLog.tag} 📦 Clearing all ${_mapBox.length} values of the box!');
    _mapBox.clear();
  }
}
