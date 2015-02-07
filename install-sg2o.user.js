// ==UserScript==
// @name          SG2O
// @namespace     sg2o
// @description   Bring old functions from sg+ back to SGv2.
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
  var sg2o = document.createElement('script');
  sg2o.type = 'text/javascript';
  sg2o.src = 'https://raw.githack.com/gerritwalther/sg2o/master/sg2o.user.js';
  document.body.appendChild(sg2o);
})();
