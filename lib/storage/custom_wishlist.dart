part of sg2o;

/// Class for custom wishlist games.
class CustomWishList {

    Map currentWishList = new Map();

    CustomWishList() {
        loadWishList();
    }

    /// Loads the wishlist from local storage.
    void loadWishList() {
        currentWishList = JSON.decode(storage.getJson(keyCustomWishList));
    }

    /// Stores the current wishlist to the local storage.
    void storeWishList() {
        storage.add(keyCustomWishList, new JsonEncoder().convert(currentWishList).toString());
    }

    /// Returns [true] if [game] is on the custom wishlist.
    bool isOnWishList(String game) {
        return currentWishList.containsKey(game);
    }

    /// Adds the [game] to the current wishlist and stores it.
    void addGameToWishList(String game) {
        currentWishList[game] = 'true';
        storeWishList();
    }

    /// Removes the [game] from the current wishlist and stores it.
    void removeGameFromWishList(String game) {
        currentWishList.remove(game);
        storeWishList();
    }
}