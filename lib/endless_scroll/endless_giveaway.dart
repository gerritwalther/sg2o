part of sg2o;

class EndlessGiveAway extends EndlessScroll {

    String type = '';
    String query = '';

    /// Constructor for endless scroll on giveaway page. Specifies the gridViewContainer as [itemsContainer].
    EndlessGiveAway() : super() {
        if (Uri.base.queryParameters.containsKey('type')) {
            /// http://www.steamgifts.com/giveaways/search?page=2&q=life+is+strange
            /// http://www.steamgifts.com/giveaways/search?page=2&q=life+is+strange&type=new
            type = Uri.base.queryParameters['type'];
            window.console.log('Page type is $type');
        }
        if (Uri.base.queryParameters.containsKey('q')) {
            query = Uri.base.queryParameters['q'];
            window.console.log('Query is $query');
        }
        itemsContainer = querySelector('.$classGridViewContainer');
    }

    void updatePage(num page) {
        updatePagination('Loading next page  ', true);
        HttpRequest.request('$urlGiveAwayPage$nextPage&type=$type&q=$query').then((HttpRequest resp) {
            Document nextPageDocument = domParser.parseFromString(resp.responseText, 'text/html');
            // Create gridView of new page and append it to the container.
            Element nextPageGiveawayGrid = gridView.collapseGAListOnDocument(nextPageDocument);
            itemsContainer
                ..append(this.createHeading('Page $page', false))
                ..append(nextPageGiveawayGrid);

            updatePagination('Scroll to load next page!', false);

            isLastPage = isLastPageReached(nextPageDocument);
        });
    }

}