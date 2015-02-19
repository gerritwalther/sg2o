part of sg2o;



class MyStorage {

  Storage storage = window.localStorage;

  MyStorage() {
    initDefaults();
  }

  void add(String key, String value) {
    storage[keyName + key] = value;
    storage[keyName + key + keyNameTimestamp] = new DateTime.now().millisecondsSinceEpoch.toString();
  }

  String get(String key) {
    return storage[keyName + key];
  }

  bool getBool(String key) {
    String currentValue = get(key);
    return currentValue == 'true';
  }

  String getForeign(String key) {
    return storage[key];
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
      DateTime aYearAgo = new DateTime.now().subtract(new Duration(days: daysForExpiration));
      if (timestamp.isBefore(aYearAgo)) {
        storage.remove(key);
        storage.remove(key + keyNameTimestamp);
      }
    }
  }

  ///
  bool containsKey(String key) {
    return storage.containsKey(keyName + key);
  }

  initDefaults() {
    if ( ! containsKey(keyHideGAs)) {
      add(keyHideGAs, 'false');
    }
  }

  /// TODO move this somewhere else.
  bool showEnteredGiveaways() {
    return !getBool(keyHideGAs);
  }
}