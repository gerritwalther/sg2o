part of sg2o;

class EndlessGiveAway extends EndlessScroll {

  EndlessGiveAway () : super() {
    itemsContainer = querySelector('.$classGridViewContainer');
  }

  void updatePage(num page) {
    HttpRequest.request('$urlGiveAwayPage$nextPage').then((HttpRequest resp) {
        Document nextPageDocument = domParser.parseFromString(resp.responseText, 'text/html');
        Element nextPageGiveawayGrid = gridView.collapseGAListOnDocument(nextPageDocument);
        itemsContainer
          ..append(this.createHeading(page))
          ..append(nextPageGiveawayGrid);

        ElementList pagination = nextPageDocument.querySelector('.$classPagination').children;
        updatePagination(pagination.first, pagination.last);
      }
    );
  }

}