part of sg2o;

/// Container class for all giveaway pages.
class GridView {

    List<GiveAwayPage> giveAwayPages;

    GridView() {
        giveAwayPages = new List();
    }

    /// Creates a [GiveAwayPage] for the pinned giveaways.
    void collapsePinnedGAs() {
        ElementList giveAwayElements = document.querySelectorAll('.$classPinnedGiveaways>.$classGiveawayRow');
        Element parentElement = giveAwayElements[0].parent;

        parentElement
            ..parent.insertBefore(createHeading('Pinned giveaways', '/'), parentElement)
            ..setAttribute('style', 'margin-top: 0px;');

        GiveAwayPage giveAwayPage = new GiveAwayPage();

        giveAwayPage.collapseGAs(0, document, classPinnedGAContainer, parentElement, giveAwayElements);

        giveAwayPages.add(giveAwayPage);
    }

    /// Used for the first giveawayPage. Collapses all giveaways on the first page (except pinned GAs).
    void collapseGAList() {
        int numberPinnedGAs = querySelectorAll('.$classPinnedGiveaways>.$classGiveawayRow').length;
        ElementList giveAwayElements = document.querySelectorAll('.$classGiveawayRow');
        Element parentElement = giveAwayElements[numberPinnedGAs].parent;

        GiveAwayPage giveAwayPage = new GiveAwayPage();

        giveAwayPage.collapseGAs(numberPinnedGAs, document, classGridViewContainer, parentElement, giveAwayElements);

        giveAwayPages.add(giveAwayPage);
    }

    /// Collapses all giveaways on [documentToQuery]. Used for each successive page after the first.
    Element collapseGAListOnDocument(Document documentToQuery) {
        int numberPinnedGAs = documentToQuery.querySelectorAll('.$classPinnedGiveaways>.$classGiveawayRow').length;
        ElementList giveAwayElements = documentToQuery.querySelectorAll('.$classGiveawayRow');
        Element parentElement = giveAwayElements[numberPinnedGAs].parent;

        GiveAwayPage giveAwayPage = new GiveAwayPage();

        Element collapsedGAList = giveAwayPage.collapseGAs(numberPinnedGAs, documentToQuery, null, parentElement, giveAwayElements);

        giveAwayPages.add(giveAwayPage);

        return collapsedGAList;
    }

    /// Call this function when updating border colors for all visible giveaways with a matching [name].
    void updateVisibilityAndBorders(String name) {
        giveAwayPages.forEach((GiveAwayPage gap) {
            gap.updateBorders(name);
        });
    }

    /// Call this function to hide all visible giveaways matching [name].
    void hideTemporarily(String name) {
        giveAwayPages.forEach((GiveAwayPage gap) {
            gap.hideTemporarily(name);
        });
    }
}