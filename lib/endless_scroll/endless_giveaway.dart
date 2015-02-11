part of sg2o;

class EndlessGiveAway extends EndlessScroll {

  EndlessGiveAway () : super() {
    itemsContainer = querySelector('.gridview-container');
  }

  void updatePage(num page) {
    HttpRequest.request('/giveaways/search?page=$nextPage').then((HttpRequest resp) {
        Document nextPageDocument = domParser.parseFromString(resp.responseText, 'text/html');
        Element nextPageGiveawayGrid = collapseGAListOnDocument(nextPageDocument);
        itemsContainer
          ..append(this.createHeading(page))
          ..append(nextPageGiveawayGrid);

        ElementList pagination = nextPageDocument.querySelector('.pagination').children;
        updatePagination(pagination.first, pagination.last);
      }
    );
  }

}