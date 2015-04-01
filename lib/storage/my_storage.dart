part of sg2o;

/// Class for accessing local storage, which also adds a key with a timestamp when last updated.
class MyStorage {

    Storage storage = window.localStorage;

    MyStorage() {
        initDefaults();
    }

    /// Adds two keys to the localstorage, both prepended by a plugin-string and one with appended timestamp-String. Second gets the current time.
    void add(String key, String value) {
        storage[keyName + key] = value;
        storage[keyName + key + keyNameTimestamp] = new DateTime.now().millisecondsSinceEpoch.toString();
    }

    /// Gets the value for [key].
    String get(String key) {
        String value = storage[keyName + key];
        return (value != null) ? value : '';
    }

    /// Gets [true] or [false] for the specified key. Also works on keys different then 'true' or 'false'.
    bool getBool(String key) {
        String currentValue = get(key);
        return currentValue == 'true';
    }

    /// Returns only the value for [key] if not empty, otherwise an empty JSON object '{}'.
    String getJson(String key) {
        String currentValue = get(key);
        return (currentValue != '') ? currentValue : '{}';
    }

    /// Returns a [DateTime] object representing the last update for [key].
    DateTime getLastUpdate(String key) {
        String keyTimeStamp = keyName + key + keyNameTimestamp;
        String timeStamp = storage[keyTimeStamp];
        if (timeStamp != null) {
            return new DateTime.fromMillisecondsSinceEpoch(num.parse(storage[keyTimeStamp], (String s) {
                return 0;
            }));
        } else {
            return new DateTime.fromMillisecondsSinceEpoch(0);
        }
    }

    /// Returns the value for a foreign (not by sg2o) key.
    String getForeign(String key) {
        if (storage.containsKey(key)) {
            return storage[key];
        } else {
            return '';
        }
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
        if (!key.endsWith(keyNameTimestamp)) {
            DateTime timestamp = new DateTime.fromMillisecondsSinceEpoch(int.parse(storage[key + keyNameTimestamp]));
            DateTime aYearAgo = new DateTime.now().subtract(new Duration(days: daysForExpiration));
            if (timestamp.isBefore(aYearAgo)) {
                storage.remove(key);
                storage.remove(key + keyNameTimestamp);
            }
        }
    }

    /// Returns [true] if key is in local storage.
    bool containsKey(String key) {
        return storage.containsKey(keyName + key);
    }

    /// Initializes default values for own keys.
    initDefaults() {
        initDefault(keyHideGAs, 'false');
        initDefault(keyAutomaticBlackList, 'false');
        initDefault(keyAutomaticPageReload, 'true');
        initDefault(keyRemoveFeatured, 'true');

        initDefault(groupColorKey, groupColor);
        initDefault(contributorAboveLevelColorKey, contributorAboveLevelColor);
        initDefault(contributorBelowLevelColorKey, contributorBelowLevelColor);
        initDefault(wishListColorKey, wishListColor);
        initDefault(whiteListColorKey, whiteListColor);
    }

    /// Helper function to have only one line per initialization.
    initDefault(String key, String defaultValue) {
        if (!containsKey(key)) {
            add(key, defaultValue);
        }
    }
}