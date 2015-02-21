/// The sg2o library.
library sg2o;

import 'dart:html';
import 'dart:convert';

part 'constants.dart';
part 'my_string.dart';
part 'sidebar.dart';
part 'user.dart';
part 'dom/my_dom.dart';
part 'endless_scroll/endless_scroll.dart';
part 'endless_scroll/endless_giveaway.dart';
part 'giveaway/blacklist.dart';
part 'giveaway/giveaway.dart';
part 'giveaway/wishlist.dart';
part 'settings/settings.dart';
part 'storage/custom_wishlist.dart';
part 'storage/my_storage.dart';
part 'styles/border_styles.dart';
part 'styles/common_styles.dart';
part 'styles/settings_styles.dart';
part 'styles/styles.dart';

MyStorage storage = new MyStorage();
BlackList blackList = new BlackList();
WishList wishList = new WishList();
CustomWishList customWishList = new CustomWishList();

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
  }
  addStopStyleParagraph(parentElementToInsertGAs);
  return parentElementToInsertGAs;
}

void collapsePinnedGAs() {
  ElementList giveAwayElements = document.querySelectorAll('.$classPinnedGiveaways>.$classGiveawayRow');
  Element parentElement = giveAwayElements[0].parent;

  parentElement
      ..parent.insertBefore(createHeading('Pinned giveaways', '/'), parentElement)
      ..setAttribute('style', 'margin-top: 0px;');

  collapseGAs(0, document, classPinnedGAContainer, parentElement, giveAwayElements);
}

void collapseGAList() {
  int numberPinnedGAs = querySelectorAll('.$classPinnedGiveaways>.$classGiveawayRow').length;
  ElementList giveAwayElements = document.querySelectorAll('.$classGiveawayRow');
  Element parentElement = giveAwayElements[numberPinnedGAs].parent;
  collapseGAs(numberPinnedGAs, document, classGridViewContainer, parentElement, giveAwayElements);
}

Element collapseGAListOnDocument(Document documentToQuery) {
  int numberPinnedGAs = documentToQuery.querySelectorAll('.$classPinnedGiveaways>.$classGiveawayRow').length;
  ElementList giveAwayElements = documentToQuery.querySelectorAll('.$classGiveawayRow');
  Element parentElement = giveAwayElements[numberPinnedGAs].parent;
  return collapseGAs(numberPinnedGAs, documentToQuery, null, parentElement, giveAwayElements);
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
//  Element voteContainer = widgetContainers.elementAt(1); //TODO find a better way to select this, as the community vote does not always exist.
  Element forumContainer = widgetContainers.elementAt(widgetContainers.length - 1);

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
