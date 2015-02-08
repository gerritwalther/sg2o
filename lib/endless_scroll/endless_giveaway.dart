part of sg2o;

class EndlessGiveAway extends EndlessScroll {

  EndlessGiveAway () : super() {
    itemsContainer = querySelector('.gridview-container');
  }

  void loadNextPage() {
    HttpRequest.request('/giveaways/search?page=$nextPage').then((HttpRequest resp) {
        Document nextPageDocument = domParser.parseFromString(resp.responseText, 'text/html');
        Element nextPageGiveawayGrid = collapseGAListOnDocument(nextPageDocument);
        itemsContainer
          ..append(createHeading())
          ..append(nextPageGiveawayGrid);

        ElementList pagination = nextPageDocument.querySelector('.pagination').children;
        updatePagination(pagination.first, pagination.last);
      }
    );
  }

  Element createHeading () {
    DivElement headingContainer = new DivElement();
    DivElement headingText = new DivElement();

    headingText
      ..classes.add('table__column--width-fill')
      ..innerHtml = 'Page $nextPage of $lastPage';

    headingContainer
      ..classes.add('table__heading')
      ..classes.add('sg2o-table-heading')
      ..append(headingText);

    return headingContainer;
  }
}