/// The SGv2plus library.
library SGv2plus;

import 'dart:html';

part 'giveaway.dart';
part 'my_string.dart';
part 'styles.dart';
part 'sidebar.dart';

void collapsePinnedGAs() {
  ElementList giveAwayElements = document.querySelectorAll('.pinned-giveaways>.giveaway__row-outer-wrap');
  Element parentElement = giveAwayElements[0].parent;
  parentElement.innerHtml = "";

  for(final giveAwayElement in giveAwayElements) {
    GiveAway giveAway = new GiveAway(giveAwayElement);

    parentElement.append(giveAway.wrappedWithStyles());
  }
  addStopStyleParagraph(parentElement);
}

void collapseGAList() {
  int numberPinnedGAs = querySelectorAll('.pinned-giveaways>.giveaway__row-outer-wrap').length;
  ElementList giveAwayElements = document.querySelectorAll('.giveaway__row-outer-wrap');
  Element parentElement = giveAwayElements[numberPinnedGAs].parent;
  parentElement.innerHtml = "";

  for(int i = numberPinnedGAs; i < giveAwayElements.length; i++) {
    GiveAway giveAway = new GiveAway(giveAwayElements[i]);

    parentElement.append(giveAway.wrappedWithStyles());
  }
  addStopStyleParagraph(parentElement);
}

void fixNavigation() {
  Element navigationHeaderElement = querySelector('header');

  navigationHeaderElement.classes.add('fixed-navigation-bar');
}