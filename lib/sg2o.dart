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
part 'giveaway/giveaway_page.dart';
part 'giveaway/gridview.dart';
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
GridView gridView = new GridView();

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
  Element forumContainer;

  /// Find the appropriate widget container.
  widgetContainers.forEach((Element e) {
    if (e.innerHtml.contains('Active Discussions')) {
      forumContainer = e;
    }
  });

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
