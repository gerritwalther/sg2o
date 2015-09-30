part of sg2o;

/// Class that loads the wishlist from profile once a day.
class WishList {

    Map wishList = new Map();
    DomParser domParser = new DomParser();

    WishList() {
        if (!isWishListCurrent()) {
            wishList = JSON.decode(storage.get(keyWishList));
        } else {
            loadWishListFromProfile(1);
        }
    }

    /// Sends a request to load all wishlisted games.
    void loadWishListFromProfile(num page) {
        window.console.log('Loading page $page from wishlist.');
        HttpRequest.request('$urlSteamWishList$page').then((HttpRequest resp) {
            if (resp.responseUrl != urlSteamGiftsHome) {
                Document nextPageDocument = domParser.parseFromString(resp.responseText, 'text/html');
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

    /// Returns [true] if wishlist was loaded in the last 24 hours.
    bool isWishListCurrent() {
        DateTime lastUpdated = storage.getLastUpdate(keyWishList);
        DateTime now = new DateTime.now();

        return now.difference(lastUpdated).inMilliseconds > oneDay;
    }

    /// Returns [true] if [game] is on wishlist.
    bool isOnWishList(String game) {
        return wishList.containsKey(const HtmlEscape().convert(game));
    }
}