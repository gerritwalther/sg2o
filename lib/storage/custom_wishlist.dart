part of sg2o;

class CustomWishList {

  Map currentWishList = new Map();

  CustomWishList() {
    loadWishList();
  }

  void loadWishList() {
    currentWishList = JSON.decode(storage.getJson(keyCustomWishList));
  }

  void storeWishList() {
    storage.add(keyCustomWishList, new JsonEncoder().convert(currentWishList).toString());
  }

  bool isOnWishList(String game) {
    return currentWishList.containsKey(game);
  }

  void addGameToWishList(String game) {
    currentWishList[game] = 'true';
    storeWishList();
  }

  void removeGameFromWishList(String game) {
    currentWishList.remove(game);
    storeWishList();
  }
}