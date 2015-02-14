part of sg2o;

class BlackList {

  Map blackList;

  BlackList () {
    blackList = JSON.decode(storage.getForeign(oldFilterKey));
  }

  bool isOnBlackList(String game) {
    return blackList.containsKey(game);
  }
}