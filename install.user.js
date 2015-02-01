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
(function () {
  var sgv2plus = document.createElement('script');
  sgv2plus.type = 'text/javascript';
  sgv2plus.src = 'https://rawgit.com/gerritwalther/sgv2plus/master/install.user.js';
  document.body.appendChild(sgv2plus);
})();