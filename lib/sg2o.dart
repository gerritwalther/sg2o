/// The sg2o library. containing all the required imports and parts for this plugin.
library sg2o;

import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'dart:js' as js;

part 'constants.dart';
part 'my_string.dart';
part 'sidebar.dart';
part 'user.dart';
part 'dom/color_setting.dart';
part 'dom/fa_element.dart';
part 'dom/info_element.dart';
part 'dom/my_dom.dart';
part 'dom/sg_button.dart';
part 'dom/sidebar_heading.dart';
part 'dom/spinner.dart';
part 'endless_scroll/endless_scroll.dart';
part 'endless_scroll/endless_giveaway.dart';
part 'giveaway/sgp_blacklist.dart';
part 'giveaway/giveaway.dart';
part 'giveaway/giveaway_page.dart';
part 'giveaway/gridview.dart';
part 'giveaway/profile_tooltip.dart';
part 'giveaway/simple_tooltip.dart';
part 'giveaway/wishlist.dart';
part 'layers/layer.dart';
part 'layers/navigation_menu.dart';
part 'layers/recently_blacklisted/layer_recently_blacklisted.dart';
part 'layers/settings/settings.dart';
part 'layers/settings/settings_color.dart';
part 'layers/settings/settings_common.dart';
part 'layers/settings/settings_gridview.dart';
part 'layers/settings/settings_tab.dart';
part 'layers/settings/settings_tabs.dart';
part 'layers/settings/settings_wishlist.dart';
part 'storage/custom_wishlist.dart';
part 'storage/giveaway_blacklist.dart';
part 'storage/game_blacklist_history.dart';
part 'storage/my_storage.dart';
part 'styles/border_styles.dart';
part 'styles/common_styles.dart';
part 'styles/settings_styles.dart';
part 'styles/styles.dart';
part 'styles/styles_navigation.dart';
part 'styles/tooltip.dart';
part 'util/string_util.dart';
part 'util/timeUtil.dart';

/// These classes should only be instantiated once and used everywhere.
MyStorage storage = new MyStorage();
SGPBlackList sgpBlackList = new SGPBlackList();
WishList wishList = new WishList();
CustomWishList customWishList = new CustomWishList();
GiveawayBlackList giveAwayBlackList = new GiveawayBlackList();
GameBlackListHistory gameBlackListHistory = new GameBlackListHistory();
GridView gridView = new GridView();
Settings settings;
NavigationMenu navigationMenu;
LayerRecentlyBlacklisted layerRecentlyBlacklisted;

/// Returns [true] if there are pinned giveaways.
bool pinnedGAsExist() {
    ElementList pinnedGAs = querySelectorAll('.$classPinnedGiveawaysInner>.$classGiveawayRow');

    return pinnedGAs.isNotEmpty;
}

/// Adds a class to the navigation to fix it at the top.
void fixNavigation() {
    Element navigationHeaderElement = querySelector(elementNavigation);

    navigationHeaderElement.classes.add(classFixedNavigation);
}

/// Replaces the featured giveaways on top with the recent forum posts.
void replaceFeaturedAndMoveRecentPosts() {
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

    if (querySelectorAll('.$classPinnedGiveawaysOuter').length > 0) {
        placeBeforeThis = querySelector('.$classPinnedGiveawaysOuter');
    } else {
        placeBeforeThis = querySelector('.$classSectionHeading');
    }

    if (settings.isFeaturedGAToBeRemoved()) {
        featuredContainer.remove();
    }

    if (settings.isRecentDiscussionsContainerToBeMoved()) {
        placeBeforeThis.parent
            ..insertBefore(forumContainer, placeBeforeThis);
//    ..insertBefore(voteContainer, placeBeforeThis);

        forumContainer.classes.remove(classWidgetMarginTop);
        // TODO: Might not need to add a margin top here (at least not for pinned GAs, extra removal of margin-top for pinnedGAs can be removed if this is removed).
        placeBeforeThis.classes.add(classWidgetMarginTop);
    }
}

void activateSettings() {
    settings = new Settings();
    navigationMenu = new NavigationMenu();
    layerRecentlyBlacklisted = new LayerRecentlyBlacklisted();
}
