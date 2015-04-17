// ==UserScript==
// @name          SG2O
// @namespace     sg2o
// @homepage      http://sg2o.clerius.de
// @description   Bring old functions from sg+ back to SGv2.
// @copyright     2014+, Clerius (https://sg2o.clerius.de)
// @license       GPL version 3 or any later version; http://www.gnu.org/copyleft/gpl.html
// @version       0.2.1
//
// @include   http://www.steamgifts.com/*
//
// @downloadURL https://sg2o.clerius.de/sg2o.user.js
// @updateURL https://sg2o.clerius.de/sg2o.meta.js
// @supportURL https://github.com/gerritwalther/sg2o/issues
//
// @require https://sg2o.clerius.de/jquery/jquery-ui-slider-pips.min.js
// @require https://code.jquery.com/jquery-2.1.3.min.js
// @require https://code.jquery.com/ui/1.11.4/jquery-ui.min.js
//
// @run-at    document-end
//
// ==/UserScript==
(function () {
  var pipsCss = document.createElement('link');
  pipsCss.type = 'text/css';
  pipsCss.rel = 'stylesheet';
  pipsCss.href = 'https://sg2o.clerius.de/jquery/jquery-ui-slider-pips.css';
  pipsCss.media = 'all';
  document.head.appendChild(pipsCss);

  var sg2o = document.createElement('script');
  sg2o.type = 'text/javascript';
  sg2o.src = 'http://sg2o.clerius.de/sg2o.user.js';
  document.body.appendChild(sg2o);
})();
