part of sg2o;

abstract class EndlessScroll {

  int currentPage = 1;
  int nextPage = 2;
  int lastPage;
  Element itemsContainer;
  DomParser domParser = new DomParser();

  EndlessScroll() {
    Element lastPageLink = querySelectorAll('.pagination__navigation>a').last;
    lastPage = int.parse(lastPageLink.attributes['data-page-number']);
  }

  void loadPages() {

  }

  void updatePagination(Element newPaginationInfo, Element newPaginator) {
    Element currentPagination = querySelector('.pagination');
    currentPagination
      ..children.clear()
      ..append(newPaginationInfo)
      ..append(newPaginator);
  }

  void loadNextPage();

  Element createHeading();
}