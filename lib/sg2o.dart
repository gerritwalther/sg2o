/// The sg2o library.
library sg2o;

import 'dart:html';

part 'giveaway.dart';
part 'my_string.dart';
part 'styles/styles.dart';
part 'styles/border_styles.dart';
part 'styles/common_styles.dart';
part 'sidebar.dart';
part 'dom/my_dom.dart';
part 'endless_scroll/endless_scroll.dart';
part 'endless_scroll/endless_giveaway.dart';

int myLevel = getMyLevel();

int getMyLevel() {
  Element navigationPointsElement = querySelector('.nav__points');
  if(navigationPointsElement != null) {
    return parseNumber(navigationPointsElement.parent.querySelectorAll('span')[1].getAttribute('title'));
  } else {
    return 0;
  }
}

void collapsePinnedGAs() {
  ElementList giveAwayElements = document.querySelectorAll('.pinned-giveaways>.giveaway__row-outer-wrap');
  Element parentElement = giveAwayElements[0].parent;
  parentElement
      ..innerHtml = ""
      ..classes.add('pinned-gridview-container');

  for (final giveAwayElement in giveAwayElements) {
    GiveAway giveAway = new GiveAway(giveAwayElement);

    parentElement.append(giveAway.wrappedWithStyles());
  }
  addStopStyleParagraph(parentElement);
}

void collapseGAList() {
  int numberPinnedGAs = querySelectorAll('.pinned-giveaways>.giveaway__row-outer-wrap').length;
  ElementList giveAwayElements = document.querySelectorAll('.giveaway__row-outer-wrap');
  Element parentElement = giveAwayElements[numberPinnedGAs].parent;
  parentElement
    ..innerHtml = ""
    ..classes.add('gridview-container');

  for (int i = numberPinnedGAs; i < giveAwayElements.length; i++) {
    GiveAway giveAway = new GiveAway(giveAwayElements[i]);

    parentElement.append(giveAway.wrappedWithStyles());
  }
  addStopStyleParagraph(parentElement);
}

Element collapseGAListOnDocument(Document documentToQuery) {
  int numberPinnedGAs = documentToQuery.querySelectorAll('.pinned-giveaways>.giveaway__row-outer-wrap').length;
  ElementList giveAwayElements = documentToQuery.querySelectorAll('.giveaway__row-outer-wrap');
  Element parentElement = giveAwayElements[numberPinnedGAs].parent;
  parentElement.innerHtml = '';

  for (int i = numberPinnedGAs; i < giveAwayElements.length; i++) {
    GiveAway giveAway = new GiveAway(giveAwayElements[i]);

    parentElement.append(giveAway.wrappedWithStyles());
  }
  addStopStyleParagraph(parentElement);
  return parentElement;
}

bool pinnedGAsExist() {
  ElementList pinnedGAs = querySelectorAll('.pinned-giveaways>.giveaway__row-outer-wrap');

  return pinnedGAs.isNotEmpty;
}

void fixNavigation() {
  Element navigationHeaderElement = querySelector('header');

  navigationHeaderElement.classes.add('fixed-navigation-bar');
}

void replaceFeatured() {
  Element featuredContainer = querySelector('.featured__container');
  ElementList widgetContainers = querySelectorAll('.widget-container');
  Element pageHeading = querySelector('.page__heading');
//  Element voteContainer = widgetContainers.elementAt(1);
  Element forumContainer = widgetContainers.elementAt(2);

  featuredContainer.remove();
  pageHeading.parent
    ..insertBefore(forumContainer, pageHeading);
//    ..insertBefore(voteContainer, pageHeading);

  forumContainer.classes.remove('widget-container--margin-top');
  pageHeading.classes.add('widget-container--margin-top');
}
