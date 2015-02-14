/// The sg2o library.
library sg2o;

import 'dart:html';

part 'constants.dart';
part 'giveaway.dart';
part 'my_string.dart';
part 'user.dart';
part 'dom/my_dom.dart';
part 'endless_scroll/endless_scroll.dart';
part 'endless_scroll/endless_giveaway.dart';
part 'sidebar.dart';
part 'storage/my_storage.dart';
part 'styles/border_styles.dart';
part 'styles/common_styles.dart';
part 'styles/styles.dart';

void collapsePinnedGAs() {
  ElementList giveAwayElements = document.querySelectorAll('.$classPinnedGiveaways>.$classGiveawayRow');
  Element parentElement = giveAwayElements[0].parent;
  parentElement
      ..innerHtml = ''
      ..classes.add(classPinnedGAContainer);

  parentElement
      ..parent.insertBefore(createHeading('Pinned giveaways', '/'), parentElement)
      ..setAttribute('style', 'margin-top: 0px;');

  for (final giveAwayElement in giveAwayElements) {
    GiveAway giveAway = new GiveAway(giveAwayElement);

    parentElement.append(giveAway.wrappedWithStyles());
  }
  addStopStyleParagraph(parentElement);
}

void collapseGAList() {
  int numberPinnedGAs = querySelectorAll('.$classPinnedGiveaways>.$classGiveawayRow').length;
  ElementList giveAwayElements = document.querySelectorAll('.$classGiveawayRow');
  Element parentElement = giveAwayElements[numberPinnedGAs].parent;
  parentElement
    ..innerHtml = ''
    ..classes.add(classGridViewContainer);

  for (int i = numberPinnedGAs; i < giveAwayElements.length; i++) {
    GiveAway giveAway = new GiveAway(giveAwayElements[i]);

    parentElement.append(giveAway.wrappedWithStyles());
  }
  addStopStyleParagraph(parentElement);
}

Element collapseGAListOnDocument(Document documentToQuery) {
  int numberPinnedGAs = documentToQuery.querySelectorAll('.$classPinnedGiveaways>.$classGiveawayRow').length;
  ElementList giveAwayElements = documentToQuery.querySelectorAll('.$classGiveawayRow');
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
  ElementList pinnedGAs = querySelectorAll('.$classPinnedGiveaways>.$classGiveawayRow');

  return pinnedGAs.isNotEmpty;
}

void fixNavigation() {
  Element navigationHeaderElement = querySelector(elementNavigation);

  navigationHeaderElement.classes.add(classFixedNavigation);
}

void replaceFeatured() {
  Element featuredContainer = querySelector('.$classFeaturedContainer');
  ElementList widgetContainers = querySelectorAll('.$classWidgetContainers');
  Element placeBeforeThis;
//  Element voteContainer = widgetContainers.elementAt(1);
  Element forumContainer = widgetContainers.elementAt(2);

  if (querySelectorAll('.$classPinnedGiveaways').length > 0) {
    placeBeforeThis = querySelector('.$classPinnedGiveaways');
  } else {
    placeBeforeThis = querySelector('.$classSectionHeading');
  }

  featuredContainer.remove();
  placeBeforeThis.parent
    ..insertBefore(forumContainer, placeBeforeThis);
//    ..insertBefore(voteContainer, placeBeforeThis);

  forumContainer.classes.remove(classWidgetMarginTop);
  // TODO: Might not need to add a margin top here (at least not for pinned GAs, extra removal of margin-top for pinnedGAs can be removed if this is removed).
  placeBeforeThis.classes.add(classWidgetMarginTop);
}
