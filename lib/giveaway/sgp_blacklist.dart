part of sg2o;

/// This class is used for the old blacklist entries from SG+.
class SGPBlackList {

    late Map blackList;

    /// Constructor that reads the list from local storage and parses the json element to a map.
    SGPBlackList() {
        String? jsonString = storage.getForeign(oldFilterKey);
        if (jsonString == null) {
            jsonString = '{}';
        }
        blackList = jsonDecode(jsonString);
    }

    /// Returns [true] if [game] is on the blacklist.
    bool isOnBlackList(String game) {
        return blackList.containsKey(game);
    }
}