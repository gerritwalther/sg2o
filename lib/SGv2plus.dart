/// The SGv2plus library.
library SGv2plus;

import 'dart:html';

part 'giveaway.dart';

int calculate() {
  return 6 * 7;
}

void collapsePinnedGAs() {
  var giveAwayElements = document.querySelectorAll('.giveaway__row-outer-wrap');
  giveAwayElements.forEach(printGA);
}

void printGA(Element giveAwayHtml) {
  var giveAway = new GiveAway(giveAwayHtml);
  
  giveAway.print();
}
