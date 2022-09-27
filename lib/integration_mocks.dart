part of 'integration_test.dart';

/// Used to store mocks that stay persistent throughout the whole [IntegrationScenario].
class IntegrationMocks {
  late final Map<Type, Object> _mocksMap = {};

  /// Reads a value from the box based on [type].
  T read<T extends Object>(Type type) {
    final value = _mocksMap[type] as T;
    debugPrintSynchronously(
        '${IntegrationLog.tag} 📦 Reading \'$type\' value: $value as ${value.runtimeType} from mocks!');
    return value;
  }

  /// Writes a value to the box based on the [runtimeType] of [mock].
  void write(Object mock) {
    debugPrintSynchronously(
        '${IntegrationLog.tag} 📦 Writing \'${mock.runtimeType}\' to mocks!');
    _mocksMap[mock.runtimeType] = mock;
  }

  /// Deletes a value from the box based on [type].
  void delete(Type type) {
    final deletedValue = _mocksMap.remove(type);
    debugPrintSynchronously(
        '${IntegrationLog.tag} 📦 Deleted \'$type\' deletedValue: $deletedValue from the box!');
  }

  /// Clears all values of the [_mocksMap].
  void clear() {
    debugPrintSynchronously(
        '${IntegrationLog.tag} 📦 Clearing all ${_mocksMap.length} values of the box!');
    _mocksMap.clear();
  }
}
