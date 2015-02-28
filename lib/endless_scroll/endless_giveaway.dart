part of sg2o;

class EndlessGiveAway extends EndlessScroll {

    EndlessGiveAway() : super() {
        itemsContainer = querySelector('.$classGridViewContainer');
    }

    void updatePage(num page) {
        updatePagination('Loading next page  ', true);
        HttpRequest.request('$urlGiveAwayPage$nextPage').then((HttpRequest resp) {
            Document nextPageDocument = domParser.parseFromString(resp.responseText, 'text/html');
            ElementList pagination = nextPageDocument.querySelector('.$classPagination').children;
            ElementList paginator = nextPageDocument.querySelectorAll('.$classPaginationNavigation>a');
            Element nextPageGiveawayGrid = gridView.collapseGAListOnDocument(nextPageDocument);
            itemsContainer
                ..append(this.createHeading('Page $page of $lastPage', false))
                ..append(nextPageGiveawayGrid);

            updatePagination('Scroll to load next page!', false);

            if (paginator.last.classes.contains(classIsSelected)) {
                currentPage = lastPage;
            }
        });
    }

}