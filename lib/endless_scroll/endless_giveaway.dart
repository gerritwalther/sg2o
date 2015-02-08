part of sg2o;

class EndlessGiveAway extends EndlessScroll {

  EndlessGiveAway () : super() {
    itemsContainer = querySelector('.gridview-container');
  }

  void loadNextPage(Event e) {
    int scrollTop = document.body.scrollHeight;
    int paginationTop = querySelector('.pagination').offsetTop;
    if (scrollTop > paginationTop && !isLoading && nextPage < lastPage) {
      isLoading = true;
      updatePage();
      nextPage += 1;
      isLoading = false;
    }
  }

  void updatePage() {
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