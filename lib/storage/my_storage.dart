part of sg2o;

const String keyName = 'sg2o-';
const String keyNameTimestamp = '-timestamp';

class MyStorage {

  Storage storage = window.localStorage;

  MyStorage() {

  }

  void add(String key, String value) {
    storage[keyName + key] = value;
    storage[keyName + key + keyNameTimestamp] = new DateTime.now().millisecondsSinceEpoch.toString();
  }

  String get(String key) {
    return storage[keyName + key];
  }

  /**
   * Delete all keys that are older than a year.
   */
  void cleanUp() {
    storage.forEach(_checkAndDelete);
  }

  /**
   * Checks if a key hasn't been updated for a long time and deletes it. Don't need to prepend keyName, as these are stored keys.
   */
  void _checkAndDelete(String key, String value) {
    if ( ! key.endsWith(keyNameTimestamp)) {
      DateTime timestamp = new DateTime.fromMillisecondsSinceEpoch(int.parse(storage[key + keyNameTimestamp]));
      DateTime aYearAgo = new DateTime.now().subtract(new Duration(days: 365));
      if (timestamp.isBefore(aYearAgo)) {
        storage.remove(key);
        storage.remove(key + keyNameTimestamp);
      }
    }
  }

}