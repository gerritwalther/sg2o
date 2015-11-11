part of sg2o;

/// Abstract class to implement for further endless scrolling pages.
abstract class EndlessScroll {

    int currentPage = 1;
    int nextPage = 2;
    /// This is the container where the new content should be appended. Has to be specified by each constructor.
    Element itemsContainer;
    DomParser domParser = new DomParser();
    bool isLoading = false;
    num lastLoading;
    bool isLastPage = false;

    /// Use this constructor to initialize the class with the correct pagination element and pages count.
    EndlessScroll() {
        lastLoading = 0;
        isLastPage = isLastPageReached(document);
    }

    /// Returns [true] if the last element in the paginator is 'selected'.
    bool isLastPageReached(Document document) {
        ElementList paginator = document.querySelectorAll('.$classPaginationNavigation>a');
        return paginator.last.classes.contains(classIsSelected);
    }

    /// Call this function once to start loading pages.
    void loadPages() {
        updatePagination('Scroll to load next Page!', false);
        // Periodically load next page. E.g. if filter is active and does not show any giveaways.
//        new Timer.periodic(const Duration(seconds: 1), (loadNextPageWithTimer));
        window.onScroll.listen(loadNextPage);
    }

    /// Wrapper function to use with the timer.
    void loadNextPageWithTimer(Timer t) {
        loadNextPage(new Event(''));
        if (isLastPage) {
            t.cancel();
        }
    }

    /// This function loads the nextPage and calls updatePage, which has to be implemented for each site.
    void loadNextPage(Event e) {
        // Workaround to not load new pages on every scroll event and not two pages at once.
        num now = new DateTime.now().millisecondsSinceEpoch;
        if (isLoading || now - lastLoading < 600) {
            return;
        } else {
            isLoading = true;
            lastLoading = now;
        }
        Element pagination = querySelector('.$classPagination');
        if (isLastPage) {
            updatePagination('All pages loaded!', false);
        } else {
            if (isElementCompletelyVisible(pagination)) {
                updatePage(nextPage);
                nextPage += 1;
            }
        }
        isLoading = false;
    }

    /// This function replaces the pagination content with a specified [content] and an optional spinner.
    void updatePagination(String content, bool addSpinner) {
        Element currentPagination = querySelector('.$classPagination');
        currentPagination
            ..children.clear()
            ..append(createHeading(content, addSpinner));
    }

    /// Abstract function to be implemented. This function should get the specified [page] and append its content to the [itemsContainer].
    void updatePage(num page);

    /// Returns an [Element] with specified [content] and optional spinner [addSpinner].
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