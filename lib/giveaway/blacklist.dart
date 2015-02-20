part of sg2o;

class BlackList {

  Map blackList;

  BlackList () {
    String jsonString = storage.getForeign(oldFilterKey);
    if (jsonString == '') {
      jsonString = '{}';
    }
    blackList = JSON.decode(jsonString);
  }

  bool isOnBlackList(String game) {
    return blackList.containsKey(game);
  }
}