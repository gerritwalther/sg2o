import 'package:SGv2plus/SGv2plus.dart' as SGv2plus;
import 'package:path/path.dart' as path;
import 'dart:html';

main() {
  window.console.log('Hello this is sgv2plus');
  String currentUrl = document.baseUri;
  List<String> urlParts = path.split(currentUrl);
  SGv2plus.SideBar sidebar = new SGv2plus.SideBar();
  SGv2plus.addStylesToHeader();
  SGv2plus.fixNavigation();

  if (urlParts.length == 1 || urlParts.elementAt(1) == "giveaways") { // We are on the GA page
    if(SGv2plus.pinnedGAsExist()) {
      SGv2plus.collapsePinnedGAs();
    }
    SGv2plus.collapseGAList();
    SGv2plus.addMarginToHeader();
  }

  if (sidebar.isSidebarPresent()) {
    sidebar.fixSidebar();
  }
}
