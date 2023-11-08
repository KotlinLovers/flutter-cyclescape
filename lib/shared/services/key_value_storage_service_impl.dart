import 'package:cyclescape/shared/services/key_value_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorageImpl extends KeyValueStorage {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();
    if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    }
    // Puedes continuar para otros tipos si es necesario
    else {
      throw UnimplementedError('Get not implemented for type $T');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();
    if (T == int) {
      await prefs.setInt(key, value as int);
    } else if (T == String) {
      await prefs.setString(key, value as String);
    } else if (T == bool) {
      await prefs.setBool(key, value as bool);
    }
    // Puedes continuar para otros tipos si es necesario
    else {
      throw UnimplementedError('Set not implemented for type $T');
    }
  }
}
