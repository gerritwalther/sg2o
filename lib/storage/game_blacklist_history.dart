part of sg2o;

/// Class for a list of recently added games to the blacklist (by game).
class GameBlackListHistory {

    Map<String, BlackListedGame> recentlyBlacklisted;

    GiveawayBlackList() {
        loadBlackList();
    }

    /// Loads the blacklist from local storage.
    void loadBlackList() {
        recentlyBlacklisted = JSON.decode(storage.getJson(keyRecentlyBlacklistedGiveaways));
        recentlyBlacklisted.forEach((key, value) {
            recentlyBlacklisted[key] = BlackListedGame.fromJson(value); // Ignore the IDE warning here
        });
    }

    /// Stores the current blacklist history to the local storage.
    void storeList() {
        storage.add(keyRecentlyBlacklistedGiveaways, JSON.encode(recentlyBlacklisted).toString());
    }

    /// Adds the [sgGameId] to the list of recently blacklisted games and stores it.
    void addToBlackList(String name, String sgGameId, String steamId) {
        loadBlackList();
        if (recentlyBlacklisted.length > 10) {
            removeOldest();
        }
        recentlyBlacklisted[sgGameId] = new BlackListedGame.create(name, sgGameId, steamId);
        print('Adding "$name" to recently blacklisted games.');
        storeList();
    }

    bool isOnList(String gameId) {
        return recentlyBlacklisted.containsKey(gameId);
    }

    void removeOldest() {
        DateTime oldest = new DateTime.now();
        String oldestGameId = '';
        recentlyBlacklisted.forEach((k, BlackListedGame blg) {
            if (blg.added.isAfter(oldest)) {
                oldest = blg.added;
                oldestGameId = blg.sgGameId;
            }
        });

        if (oldestGameId != '') {
            recentlyBlacklisted.remove(oldestGameId);
        }
    }

    /// Removes the [sgGameId] from the current blacklist.
    void removeFromBlackList(String name, String sgGameId) {
        print('Removing $name from the recently deleted games.');
        removeFromSGBlackList(sgGameId);
    }

    void removeFromSGBlackList(String sgGameId) {
        Map<String, String> formData = new Map();
        String xsrfToken = querySelectorAll('input[name="xsrf_token"]')[0].getAttribute('value');
        formData['xsrf_token'] = xsrfToken;
        formData['game_id'] = sgGameId;
        formData['do'] = 'remove_filter';
        recentlyBlacklisted.remove(sgGameId);
        HttpRequest.postFormData('/ajax.php', formData);
    }

    void printAll() {
        recentlyBlacklisted.forEach((k, v) {
            print('$k: ${v.toString()}');
        });
    }

    List<BlackListedGame> getAll() {
        loadBlackList();
        return recentlyBlacklisted.values.toList();
    }
}

class BlackListedGame {
    String name;
    DateTime added;
    String sgGameId;
    String steamId;

    BlackListedGame();

    @override
    bool operator==(BlackListedGame other) {
        return this.name == other.name && this.sgGameId == other.sgGameId && this.steamId == other.steamId;
    }

    Map toJson() {
        Map map = new Map();
        map['name'] = this.name;
        map['added'] = this.added.toIso8601String();
        map['sgGameId'] = this.sgGameId;
        map['steamId'] = this.steamId;
        return map;
    }

    static BlackListedGame fromJson(Map json) {
        BlackListedGame blackListedGame = new BlackListedGame();
        blackListedGame.name = json['name'];
        blackListedGame.added = DateTime.parse(json['added']);
        blackListedGame.sgGameId = json['sgGameId'];
        blackListedGame.steamId = json['steamId'];
        return blackListedGame;
    }

    @override
    String toString() {
        return '$name, $added, $sgGameId, $steamId';
    }

    factory BlackListedGame.create(String name, String gameId, String steamId) {
        BlackListedGame blackListedGame = new BlackListedGame();
        blackListedGame.name = name;
        blackListedGame.sgGameId = gameId;
        blackListedGame.added = new DateTime.now();
        blackListedGame.steamId = steamId;
        return blackListedGame;
    }
}