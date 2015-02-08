import 'package:sg2o/sg2o.dart' as sg2o;
import 'package:path/path.dart' as path;
import 'dart:html';

main() {
  String currentUrl = document.baseUri;
  List<String> urlParts = path.split(currentUrl);
  sg2o.Styles styles = new sg2o.Styles();

  styles.addStyles();
  sg2o.fixNavigation();

  if (urlParts.length == 1 || urlParts.elementAt(1) == "giveaways") { // We are on the GA page
    if(sg2o.pinnedGAsExist()) {
      sg2o.collapsePinnedGAs();
    }
    sg2o.collapseGAList();
    styles.addMarginToHeader();
    sg2o.replaceFeatured();

    if (sg2o.paginationAvailable()) {
      sg2o.EndlessGiveAway endlessGiveAwayScroll = new sg2o.EndlessGiveAway();
      endlessGiveAwayScroll.loadPages();
    }
  }

  sg2o.SideBar sidebar = new sg2o.SideBar();

  if (sidebar.isSidebarPresent()) {
    sidebar.fixSidebar();
  }
}
