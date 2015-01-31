// ==UserScript==
// @name          SGv2plus
// @namespace     sgv2plus
// @description   Bring old functions from sg+ to SGv2.
// @copyright     2014+, Clerius (https://github.com/gerritwalther)
// @license       GPL version 3 or any later version; http://www.gnu.org/copyleft/gpl.html
// @version       0.1
//
// @include   http://www.steamgifts.com/*
//
// @run-at    document-end
//
// ==/UserScript==

import 'package:SGv2plus/SGv2plus.dart' as SGv2plus;
import 'package:path/path.dart' as path;
import 'dart:html';

main() {
  String currentUrl = document.baseUri;
  List<String> urlParts = path.split(currentUrl);

  if (urlParts.length == 1) { // We are on the main page
    SGv2plus.collapsePinnedGAs();
    SGv2plus.addMarginToHeader();
  }
}
