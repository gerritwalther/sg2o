part of sg2o;

/// Class for a list of recently added games to the blacklist (by game).
class GameBlackListHistory {

    Map<String, BlackListedGame> recentlyBlacklisted = new Map();

    GiveawayBlackList() {
        loadBlackList();
    }

    /// Loads the blacklist from local storage.
    void loadBlackList() {
        recentlyBlacklisted = JSON.decode(storage.getJson(keyRecentlyBlacklistedGiveaways));
    }

    /// Stores the current blacklist history to the local storage.
    void storeList() {
        storage.add(keyRecentlyBlacklistedGiveaways, JSON.encode(recentlyBlacklisted).toString());
    }

    /// Adds the [gameId] to the list of recently blacklisted games and stores it.
    void addToBlackList(String name, String gameId) {
        if (recentlyBlacklisted.length > 10) {
            removeOldest();
        }
        recentlyBlacklisted[gameId] = new BlackListedGame.create(name, gameId);
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
                oldestGameId = blg.gameId;
            }
        });

        if (oldestGameId != '') {
            recentlyBlacklisted.remove(oldestGameId);
        }
    }

    /// Removes the [gameId] from the current blacklist.
    void removeFromBlackList(String name, String gameId) {
        print('Removing $name from the recently deleted games.');
        recentlyBlacklisted.remove(gameId);
    }

    void printAll() {
        recentlyBlacklisted.forEach((k, v) {
            print('$k: ${v.toString()}');
        });
    }
}

class BlackListedGame {
    String name;
    DateTime added;
    String gameId;

    BlackListedGame();

    @override
    bool operator==(BlackListedGame other) {
        return this.name == other.name && this.gameId == other.gameId;
    }

    Map toJson() {
        Map map = new Map();
        map['name'] = this.name;
        map['added'] = this.added.toIso8601String();
        map['gameId'] = this.gameId;
        return map;
    }

    @override
    String toString() {
        return '$name, $added, $gameId';
    }

    factory BlackListedGame.create(String name, String gameId) {
        BlackListedGame blackListedGame = new BlackListedGame();
        blackListedGame.name = name;
        blackListedGame.gameId = gameId;
        blackListedGame.added = new DateTime.now();
        return blackListedGame;
    }
}