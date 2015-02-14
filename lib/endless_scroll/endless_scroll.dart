part of sg2o;

abstract class EndlessScroll {

  int currentPage = 1;
  int nextPage = 2;
  int lastPage;
  Element itemsContainer;
  DomParser domParser = new DomParser();
  bool isLoading = false;
  num lastLoading;

  EndlessScroll() {
    Element lastPageLink = querySelectorAll('.$classPaginationNavigation>a').last;
    lastPage = int.parse(lastPageLink.attributes['data-page-number']);
    lastLoading = new DateTime.now().millisecondsSinceEpoch;
  }

  void loadPages() {
    window.onScroll.listen(loadNextPage);
  }

  void loadNextPage(Event e) {
    num now = new DateTime.now().millisecondsSinceEpoch;
    if (isLoading || now - lastLoading < 700) {
      return;
    } else {
      isLoading = true;
      lastLoading = e.timeStamp;
    }
    Element pagination = querySelector('.$classPagination');
    if (isElementCompletelyVisible(pagination) && nextPage <= lastPage) {
      updatePage(nextPage);
      nextPage += 1;
    }
    isLoading = false;
  }

  void updatePagination(Element newPaginationInfo, Element newPaginator) {
    Element currentPagination = querySelector('.$classPagination');
    currentPagination
      ..children.clear()
      ..append(newPaginationInfo)
      ..append(newPaginator);
  }

  void updatePage(num page);

  Element createHeading (num page) {
    DivElement headingContainer = new DivElement();
    DivElement headingText = new DivElement();

    headingText
      ..classes.add(classTableColumnWidthFill)
      ..innerHtml = 'Page $page of $lastPage';

    headingContainer
      ..classes.add(classTableHeading)
      ..classes.add(classSg2oTableHeading)
      ..append(headingText);

    return headingContainer;
  }
}