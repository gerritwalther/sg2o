/// The SGv2plus library.
library SGv2plus;

import 'dart:html';

part 'giveaway.dart';
part 'my_string.dart';

void collapsePinnedGAs() {
  ElementList giveAwayElements = document.querySelectorAll('.giveaway__row-outer-wrap');
  Element parentElement = giveAwayElements[0].parent;
  parentElement.innerHtml = "";

  for(final giveAwayElement in giveAwayElements) {
    GiveAway giveAway = new GiveAway(giveAwayElement);

    parentElement.append(giveAway.wrappedWithStyles());
  }

  Element stopStyles = new ParagraphElement();

  stopStyles.setAttribute('style', 'clear:both;');

  parentElement.append(stopStyles);
}

void addMarginToHeader() {
  Element headerElement = querySelector('.page__heading');

  headerElement.setAttribute('style', 'margin-bottom: 0.5em');
}

void fixNavigation() {
  Element navigationElement = querySelector('header');

  navigationElement.setAttribute('style', 'position: fixed; top: 0; left: 0; right: 0; z-index: 9999; width: 100%;');
}