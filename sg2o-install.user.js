// ==UserScript==
// @name          SG2O
// @namespace     sg2o
// @homepage      https://sg2o.clerius.de
// @description   Bring old functions from sg+ back to SGv2.
// @copyright     2014+, Clerius (https://sg2o.clerius.de)
// @license       GPL version 3 or any later version; http://www.gnu.org/copyleft/gpl.html
// @version       0.2.22
//
// @include   *://www.steamgifts.com/*
//
// @downloadURL https://sg2o.clerius.de/sg2o-install.user.js
// @updateURL https://sg2o.clerius.de/sg2o-install.meta.js
// @supportURL https://github.com/gerritwalther/sg2o/issues
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

  var pips = document.createElement('script');
  pips.type = 'text/javascript';
  pips.src = 'https://sg2o.clerius.de/jquery/jquery-ui-slider-pips.min.js';
  document.head.appendChild(pips);

  var powertipCss = document.createElement('link');
  powertipCss.type = 'text/css';
  powertipCss.rel = 'stylesheet';
  powertipCss.href = 'https://sg2o.clerius.de/jquery/jquery-powertip-1.2.0/jquery.powertip-dark.min.css';
  powertipCss.media = 'all';
  document.head.appendChild(powertipCss);

  var powertipJs = document.createElement('script');
  powertipJs.type = 'text/javascript';
  powertipJs.src = 'https://sg2o.clerius.de/jquery/jquery-powertip-1.2.0/jquery.powertip.min.js';
  document.head.appendChild(powertipJs);

  var sg2o = document.createElement('script');
  sg2o.type = 'text/javascript';
  sg2o.src = 'https://sg2o.clerius.de/sg2o.user.js';
  document.body.appendChild(sg2o);
})();
