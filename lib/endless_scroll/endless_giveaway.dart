part of sg2o;

class EndlessGiveAway extends EndlessScroll {

    String type = '';

    /// Constructor for endless scroll on giveaway page. Specifies the gridViewContainer as [itemsContainer].
    EndlessGiveAway() : super() {
        String currentUrl = document.baseUri;
        if (currentUrl.contains('type')) {
            /// http://www.steamgifts.com/giveaways/search?page=2&type=wishlist
            type = currentUrl.split('type=').last;
            window.console.log('Page type is $type');
        }
        itemsContainer = querySelector('.$classGridViewContainer');
    }

    void updatePage(num page) {
        updatePagination('Loading next page  ', true);
        HttpRequest.request('$urlGiveAwayPage$nextPage&type=$type').then((HttpRequest resp) {
            Document nextPageDocument = domParser.parseFromString(resp.responseText, 'text/html');
            ElementList pagination = nextPageDocument.querySelector('.$classPagination').children;
            ElementList paginator = nextPageDocument.querySelectorAll('.$classPaginationNavigation>a');
            // Create gridView of new page and append it to the container.
            Element nextPageGiveawayGrid = gridView.collapseGAListOnDocument(nextPageDocument);
            itemsContainer
                ..append(this.createHeading('Page $page', false))
                ..append(nextPageGiveawayGrid);

            updatePagination('Scroll to load next page!', false);

            if (paginator.last.classes.contains(classIsSelected)) {
                isLastPage = nextPageDocument.querySelectorAll('.$classPaginationNavigation>a>span').last != 'Next';
//                currentPage = lastPage;
            }
        });
    }

}