part of sg2o;

/// Container class for all giveaway pages.
class GridView {

    List<GiveAwayPage> giveAwayPages;
    num contributorLevelFrom = 0;
    num contributorLevelTo = 10;
    num pointsFrom = 0;
    num pointsTo = 300;
    num chanceFrom = 0;
    num chanceTo = 100;

    GridView() {
        giveAwayPages = new List();
    }

    /// Creates a [GiveAwayPage] for the pinned giveaways.
    void collapsePinnedGAs() {
        // Removes the dropdown button.
        document.querySelector('.$classPinnedGiveawaysButton').click();
        ElementList giveAwayElements = document.querySelectorAll('.$classPinnedGiveawaysInner>.$classGiveawayRow');
        Element parentElement = giveAwayElements[0].parent.parent;

        parentElement
            ..parent.insertBefore(createHeading('Pinned giveaways', '/'), parentElement)
            ..setAttribute('style', 'margin-top: 0px;');

        GiveAwayPage giveAwayPage = new GiveAwayPage(contributorLevelFrom, contributorLevelTo, pointsFrom, pointsTo, chanceFrom, chanceTo);

        giveAwayPage.collapseGAs(0, document, classPinnedGAContainer, parentElement, giveAwayElements);

        giveAwayPages.add(giveAwayPage);
    }

    /// Used for the first giveawayPage. Collapses all giveaways on the first page (except pinned GAs).
    void collapseGAList() {
        int numberPinnedGAs = querySelectorAll('.$classPinnedGiveawaysInner>.$classGiveawayRow').length;
        ElementList giveAwayElements = document.querySelectorAll('.$classGiveawayRow');
        Element parentElement = giveAwayElements[numberPinnedGAs].parent;

        GiveAwayPage giveAwayPage = new GiveAwayPage(contributorLevelFrom, contributorLevelTo, pointsFrom, pointsTo, chanceFrom, chanceTo);

        giveAwayPage.collapseGAs(numberPinnedGAs, document, classGridViewContainer, parentElement, giveAwayElements);

        giveAwayPages.add(giveAwayPage);
    }

    /// Collapses all giveaways on [documentToQuery]. Used for each successive page after the first.
    Element collapseGAListOnDocument(Document documentToQuery) {
        int numberPinnedGAs = documentToQuery.querySelectorAll('.$classPinnedGiveawaysInner>.$classGiveawayRow').length;
        ElementList giveAwayElements = documentToQuery.querySelectorAll('.$classGiveawayRow');
        Element parentElement = giveAwayElements[numberPinnedGAs].parent;

        GiveAwayPage giveAwayPage = new GiveAwayPage(contributorLevelFrom, contributorLevelTo, pointsFrom, pointsTo, chanceFrom, chanceTo);

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
    void hideTemporarilyByName(String name) {
        giveAwayPages.forEach((GiveAwayPage gap) {
            gap.hideTemporarilyByName(name);
        });
    }

    /// Call this function to remove all visible giveaways matching [name].
    void removeByName(String name) {
        giveAwayPages.forEach((GiveAwayPage gap) {
            gap.removeByName(name);
        });
    }

    /// Call this function to hide all visible giveaways matching the defined ranges.
    void hideTemporarilyByRanges(num levelFrom, num levelTo, num pointsFrom, num pointsTo, num chanceFrom, num chanceTo) {
        this.contributorLevelFrom = levelFrom;
        this.contributorLevelTo = levelTo;
        this.pointsFrom = pointsFrom;
        this.pointsTo = pointsTo;
        this.chanceFrom = chanceFrom;
        this.chanceTo = chanceTo;
        giveAwayPages.forEach((GiveAwayPage gap) {
            gap.hideTemporarilyByRanges(levelFrom, levelTo, pointsFrom, pointsTo, chanceFrom, chanceTo);
        });
    }

    /// Removes the giveaway from the gridView and giveawayPage.
    void remove(GiveAway giveaway) {
        giveAwayPages.forEach((GiveAwayPage gap) {
            gap.remove(giveaway);
        });
    }
}