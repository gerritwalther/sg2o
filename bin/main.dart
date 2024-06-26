import 'package:sg2o/sg2o.dart' as sg2o;
import 'package:path/path.dart' as path;
import 'dart:html';

/// Main function that is always called.
main() {
    String? currentUrl = document.baseUri;
    List<String> urlParts = path.split(currentUrl!);
    sg2o.Styles styles = new sg2o.Styles();
    sg2o.SideBar sidebar = new sg2o.SideBar();

    sg2o.activateSettings();
    styles.addStyles();
    sg2o.fixNavigation();

    if (sg2o.isOnGAPage()) {
        // We are on the GA page
        sg2o.replaceFeaturedAndMoveRecentPosts();
        if (sg2o.pinnedGAsExist()) {
            sg2o.gridView.collapsePinnedGAs();
        }
        sg2o.gridView.collapseGAList();
        styles.addMarginToHeader();

        if (sg2o.paginationAvailable()) {
            sg2o.EndlessGiveAway endlessGiveAwayScroll = new sg2o.EndlessGiveAway();
            endlessGiveAwayScroll.loadPages();
        }

        sidebar.addFilter();
        sidebar.moveAdsToTheEnd();
    }

    if (sidebar.isSidebarPresent()) {
        sidebar.fixSidebar();
    }
}
