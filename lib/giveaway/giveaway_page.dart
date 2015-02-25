part of sg2o;

class GiveAwayPage {

  List<GiveAway> giveAways;

  GiveAwayPage() {
    giveAways = new List();
  }

  Element collapseGAs(int beginWithNo, Document documentToQuery, String classForContainer, Element parentElementToInsertGAs, ElementList gaList) {
    parentElementToInsertGAs.innerHtml = '';
    if (classForContainer != null) {
      parentElementToInsertGAs.classes.add(classForContainer);
    }

    for (int i = beginWithNo; i < gaList.length; i++) {
      GiveAway giveAway = new GiveAway(gaList.elementAt(i));

      if (giveAway.isNotBlackListed()) {
        if ((!giveAway.isEntered() || (giveAway.isEntered() && storage.showEnteredGiveaways()))) {
          parentElementToInsertGAs.append(giveAway.wrappedWithStyles());
        }
      } else {
        giveAway.addGameToBlackList();
      }
      giveAways.add(giveAway);
    }
    addStopStyleParagraph(parentElementToInsertGAs);
    return parentElementToInsertGAs;
  }

  void updateBorders(String name) {
    giveAways.forEach((GiveAway ga) {
      ga.updateBorder(name);
    });
  }

  void hideTemporarily(String name) {
    giveAways.forEach((GiveAway ga) {
      ga.hideTemporarily(name);
    });
  }
}