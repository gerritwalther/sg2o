part of sg2o;

class WishList {

  Map wishList = new Map();
  DomParser domParser = new DomParser();

  WishList () {
    if (!isWishListCurrent()) {
      wishList = JSON.decode(storage.get(keyWishList));
    } else {
      loadWishListFromProfile(1);
    }
  }


  void loadWishListFromProfile(num page) {
    window.console.log('Loading page $page');
    HttpRequest.request('$urlSteamWishList$page').then((HttpRequest resp) {
      if (resp.responseUrl != urlSteamGiftsHome) {
        Document nextPageDocument = domParser.parseFromString(resp.responseText, 'text/html');
        window.console.log(resp.responseUrl);
        window.console.log(nextPageDocument);
        ElementList wishListNames = nextPageDocument.querySelectorAll('.$classWishListName');

        wishListNames.forEach((Element e) {
          wishList[e.innerHtml] = 'true';
        });

        Element pagination = nextPageDocument.querySelector('.$classPaginationNavigation');
        if (!pagination.children.removeLast().classes.contains(classIsSelected)) {
          loadWishListFromProfile(++page);
        } else {
          storage.add(keyWishList, new JsonEncoder().convert(wishList).toString());
        }
      }
    });
  }

  bool isWishListCurrent() {
    DateTime lastUpdated = storage.getLastUpdate(keyWishList);
    DateTime now = new DateTime.now();

    return now.difference(lastUpdated).inMilliseconds > oneDay;
  }

  bool isOnWishList(String game) {
    return wishList.containsKey(game);
  }
}