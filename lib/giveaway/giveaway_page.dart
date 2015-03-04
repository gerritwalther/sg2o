part of sg2o;

/// This contains one page of giveaways. Used to propagate update events to all giveaways.
class GiveAwayPage {

    List<GiveAway> giveAways;

    GiveAwayPage() {
        giveAways = new List();
    }

    /// Returns an [Element] containing all collapsed giveaway containers for one page. Also adds the giveaways to a list to be later updated.
    Element collapseGAs(int beginWithNo, Document documentToQuery, String classForContainer, Element parentElementToInsertGAs, ElementList gaList) {
        parentElementToInsertGAs.innerHtml = '';
        if (classForContainer != null) {
            parentElementToInsertGAs.classes.add(classForContainer);
        }

        for (int i = beginWithNo; i < gaList.length; i++) {
            GiveAway giveAway = new GiveAway(gaList.elementAt(i));

            if (giveAway.isNotBlackListed()) {
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
            giveAways.add(giveAway);
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
    void hideTemporarily(String name) {
        giveAways.forEach((GiveAway ga) {
            ga.hideTemporarily(name);
        });
    }
}