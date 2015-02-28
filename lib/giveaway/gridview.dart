part of sg2o;

class GridView {

    List<GiveAwayPage> giveAwayPages;

    GridView() {
        giveAwayPages = new List();
    }

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

    void collapseGAList() {
        int numberPinnedGAs = querySelectorAll('.$classPinnedGiveaways>.$classGiveawayRow').length;
        ElementList giveAwayElements = document.querySelectorAll('.$classGiveawayRow');
        Element parentElement = giveAwayElements[numberPinnedGAs].parent;

        GiveAwayPage giveAwayPage = new GiveAwayPage();

        giveAwayPage.collapseGAs(numberPinnedGAs, document, classGridViewContainer, parentElement, giveAwayElements);

        giveAwayPages.add(giveAwayPage);
    }

    Element collapseGAListOnDocument(Document documentToQuery) {
        int numberPinnedGAs = documentToQuery.querySelectorAll('.$classPinnedGiveaways>.$classGiveawayRow').length;
        ElementList giveAwayElements = documentToQuery.querySelectorAll('.$classGiveawayRow');
        Element parentElement = giveAwayElements[numberPinnedGAs].parent;

        GiveAwayPage giveAwayPage = new GiveAwayPage();

        Element collapsedGAList = giveAwayPage.collapseGAs(numberPinnedGAs, documentToQuery, null, parentElement, giveAwayElements);

        giveAwayPages.add(giveAwayPage);

        return collapsedGAList;
    }

    void updateVisibilityAndBorders(String name) {
        giveAwayPages.forEach((GiveAwayPage gap) {
            gap.updateBorders(name);
        });
    }

    void hideTemporarily(String name) {
        giveAwayPages.forEach((GiveAwayPage gap) {
            gap.hideTemporarily(name);
        });
    }
}