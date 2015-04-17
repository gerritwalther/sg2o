part of sg2o;

/// This contains one page of giveaways. Used to propagate update events to all giveaways.
class GiveAwayPage {

    List<GiveAway> giveAways;
    num contributorLevelFrom;
    num contributorLevelTo;
    num pointsFrom;
    num pointsTo;
    num chanceFrom;
    num chanceTo;

    GiveAwayPage(num levelFrom, num levelTo, num pointsFrom, num pointsTo, num chanceFrom, num chanceTo) {
        this.giveAways = new List();
        this.contributorLevelFrom = levelFrom;
        this.contributorLevelTo = levelTo;
        this.pointsFrom = pointsFrom;
        this.pointsTo = pointsTo;
        this.chanceFrom = chanceFrom;
        this.chanceTo = chanceTo;
    }

    /// Returns an [Element] containing all collapsed giveaway containers for one page. Also adds the giveaways to a list to be later updated.
    Element collapseGAs(int beginWithNo, Document documentToQuery, String classForContainer, Element parentElementToInsertGAs, ElementList gaList) {
        parentElementToInsertGAs.innerHtml = '';
        if (classForContainer != null) {
            parentElementToInsertGAs.classes.add(classForContainer);
        }

        for (int i = beginWithNo; i < gaList.length; i++) {
            GiveAway giveAway = new GiveAway(gaList.elementAt(i));

            if (!giveAway.isGiveAwayIdBlackListed()) {
                if (giveAway.isNotSGPBlackListed()) {
                    // Add giveaway only if its not entered, or its entered and option to hide entered GAs is deactivated.
                    if ((!giveAway.isEntered() || (giveAway.isEntered() && !settings.hideEnteredGames()))) {
                        parentElementToInsertGAs.append(giveAway.wrappedWithStyles());
                    }
                } else {
                    if (settings.isAutomaticBlackListingOn()) {
                        window.console.log('Automatically adding ${giveAway.name} to the blacklist.');
                        giveAway.addGameToBlackList();
                    }
                }

                if (!giveAway.isInContributorRange(contributorLevelFrom, contributorLevelTo) ||
                        !giveAway.isInPointsRange(pointsFrom, pointsTo) ||
                        !giveAway.isInChanceRange(chanceFrom, chanceTo)) {
                    giveAway.hideTemporarily(true);
                }

                giveAways.add(giveAway);
            }
        }
        addStopStyleParagraph(parentElementToInsertGAs);
        return parentElementToInsertGAs;
    }

    /// Propagation function to update all borders of the containing giveAways in this page matching the [name].
    void updateBorders(String name) {
        giveAways.forEach((GiveAway ga) {
            ga.updateBorder(name);
        });
    }

    /// Propagation function to hide all containing giveAways in this page matching the [name].
    void hideTemporarilyByName(String name) {
        giveAways.forEach((GiveAway ga) {
            ga.hideTemporarily(name == ga.name ||
                                !ga.isInContributorRange(contributorLevelFrom, contributorLevelTo) ||
                                !ga.isInPointsRange(pointsFrom, pointsTo) ||
                                !ga.isInChanceRange(chanceFrom, chanceTo)
            );
        });
    }

    /// Propagation function to remove all containing giveAways in this page matching the [name].
    void removeByName(String name) {
        giveAways.forEach((GiveAway ga) {
            ga.removeGiveAwayContainer(name);
        });
    }

    /// Propagation function to hide all containing giveAways in this page matching the ranges.
    void hideTemporarilyByRanges(num levelFrom, num levelTo, num pointsFrom, num pointsTo, num chanceFrom, num chanceTo) {
        this.contributorLevelFrom = levelFrom;
        this.contributorLevelTo = levelTo;
        this.pointsFrom = pointsFrom;
        this.pointsTo = pointsTo;
        this.chanceFrom = chanceFrom;
        this.chanceTo = chanceTo;
        giveAways.forEach((GiveAway ga) {
            ga.hideTemporarily((!ga.isInContributorRange(levelFrom, levelTo) ||
                                !ga.isInPointsRange(pointsFrom, pointsTo) ||
                                !ga.isInChanceRange(chanceFrom, chanceTo)));
        });
    }

    /// Removes a giveaway from this giveawayPage.
    void remove(GiveAway giveaway) {
        giveAways.remove(giveaway);
    }
}