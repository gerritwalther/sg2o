part of sg2o;

/// Class for list of giveaways that should be hidden (by giveaway id).
class GiveawayBlackList {

    Map currentBlackList = new Map();

    GiveawayBlackList() {
        loadBlackList();
        cleanUpBlackList();
        storeBlackList();
    }

    /// Loads the blacklist from local storage.
    void loadBlackList() {
        currentBlackList = JSON.decode(storage.getJson(keyGiveAwayBlackList));
    }

    /// Stores the current blacklist to the local storage.
    void storeBlackList() {
        storage.add(keyGiveAwayBlackList, new JsonEncoder().convert(currentBlackList).toString());
    }

    /// Filters all giveAwayId's that are expired.
    cleanUpBlackList() {
        DateTime now = new DateTime.now();
        Map filteredBlackList = new Map();
        currentBlackList.forEach((key, value) {
            DateTime expireDate = DateTime.parse(value);
            if (expireDate.compareTo(now) > 0) {
                filteredBlackList[key] = value;
            }
        });
        currentBlackList = filteredBlackList;
    }

    /// Returns [true] if [giveAwayId] is on the blacklist.
    bool isOnBlackList(String giveAwayId) {
        return currentBlackList.containsKey(giveAwayId);
    }

    /// Adds the [giveAwayId] to the current blacklist and stores it.
    void addGameToBlackList(String giveAwayId) {
        currentBlackList[giveAwayId] = new DateTime.now().add(new Duration(days: 28)).toString();
        print('Hiding giveaway $giveAwayId for the next 4 weeks.');
        storeBlackList();
    }

    /// Removes the [giveAwayId] from the current blacklist.
    void removeGameFromBlackList(String giveAwayId) {
        currentBlackList.remove(giveAwayId);
    }
}