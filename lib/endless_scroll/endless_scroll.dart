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
        lastLoading = 0;
    }

    void loadPages() {
        updatePagination('Scroll to load next Page!', false);
        /// Workaround if there is no scrollbar
        loadNextPage(new MouseEvent('click'));
        window.onScroll.listen(loadNextPage);
    }

    void loadNextPage(Event e) {
        num now = new DateTime.now().millisecondsSinceEpoch;
        if (isLoading || now - lastLoading < 600) {
            return;
        } else {
            isLoading = true;
            lastLoading = now;
        }
        Element pagination = querySelector('.$classPagination');
        if (nextPage <= lastPage) {
            if (isElementCompletelyVisible(pagination)) {
                updatePage(nextPage);
                nextPage += 1;
            }
        } else {
            updatePagination('All pages loaded!', false);
        }
        isLoading = false;
    }

    void updatePagination(String content, bool addSpinner) {
        Element currentPagination = querySelector('.$classPagination');
        currentPagination
            ..children.clear()
            ..append(createHeading(content, addSpinner));
    }

    void updatePage(num page);

    Element createHeading(String content, bool addSpinner) {
        DivElement headingContainer = new DivElement();
        DivElement headingText = new DivElement();

        headingText
            ..classes.add(classTableColumnWidthFill)
            ..innerHtml = content;

        if (addSpinner) {
            Element spinner = new Element.tag('i');
            spinner
                ..classes.add(classFASpinner)
                ..classes.add(classFASpin)
                ..classes.add(classFontAwesome);
            headingText.append(spinner);
        }

        headingContainer
            ..classes.add(classTableHeading)
            ..classes.add(classSg2oTableHeading)
            ..append(headingText);

        return headingContainer;
    }
}