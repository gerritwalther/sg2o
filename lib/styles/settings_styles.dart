part of sg2o;

/// Class for CSS-Styles for the settings.
class SettingsStyles extends Styles {

    SettingsStyles() : super();

    void addStyles() {
        String rule =
        '''
.$classModalDialog {
  position: fixed;
  font-family: Arial, Helvetica, sans-serif;
  color: #000;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  background: rgba(0, 0, 0, 0.8);
  z-index: ${zIndexLayer};
  opacity: 0;
  -webkit-transition: opacity 400ms ease-in;
  -moz-transition: opacity 400ms ease-in;
  transition: opacity 400ms ease-in;
  pointer-events: none;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classModalDialog:target {
  opacity: 1;
  pointer-events: auto;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classModalDialog > div {
  width: 1000px;
  position: relative;
  margin: 10% auto;
  padding: 5px 20px 13px 20px;
  border-radius: 10px;
  background: #fff;
  background: -moz-linear-gradient(#fff, #999);
  background: -webkit-linear-gradient(#fff, #999);
  background: -o-linear-gradient(#fff, #999);
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classClose {
  background: #606061;
  color: #FFFFFF;
  line-height: 25px;
  position: absolute;
  right: -12px;
  text-align: center;
  top: -10px;
  width: 24px;
  text-decoration: none;
  font-weight: bold;
  -webkit-border-radius: 12px;
  -moz-border-radius: 12px;
  border-radius: 12px;
  -moz-box-shadow: 1px 1px 3px #000;
  -webkit-box-shadow: 1px 1px 3px #000;
  box-shadow: 1px 1px 3px #000;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classClose:hover {
  background: #00d9ff;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsHeading {
  font: 700 20px "Open Sans", sans-serif;
  color: $fontColor;
}
''';
        styleSheet?.insertRule(rule, 0);

        /// Tab design from http://codyhouse.co/gem/responsive-tabbed-navigation/
        rule =
        '''
.$classSettingsTabs {
    position: relative;
    width: 100%;
    max-width: 1000px;
    margin: 2em auto;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabs:after {
    content: '';
    display: table;
    clear: both;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabs nav {
    position: relative;
    overflow: auto;
    background: $settingsTabMenuBackgroundColor;
    box-shadow: rgba(203, 196, 130, 0.1288235) 0px -4px 0px inset;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabs nav ul {
    cursor: pointer;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabMenu {
    width: auto;
    background-color: transparent;
    box-shadow: inset 0 -2px 3px rgba(203, 196, 130, 0.06);
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabMenu:after {
    content: '';
    display: table;
    clear: both;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabMenu li {
    float: left;
    background-color: transparent;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabMenu a {
    position: relative;
    display: block;
    height: 30px;
    width: 80px;
    text-align: center;
    font-size: 12px;
    font-size: 0.75rem;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    font-weight: 700;
    color: #c3c2b9;
    padding-top: 20px;
    box-shadow: inset 0 2px 0 #f05451;
    background-color: rgba(200, 200, 200, 0.3);
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabMenu a:hover {
    color: #29324e;
    background-color: rgba(233, 230, 202, 0.3);
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabMenu a::before {
    /* icons */
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabMenu a.$classSettingsTabSelected {
    background-color: #ffffff !important;
    box-shadow: inset 0 2px 0 #f05451;
    color: #29324e;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabMenu li:first-child a {
    -moz-border-radius-topleft: 12px;
    -webkit-border-top-left-radius:12px;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabMenu li:last-child a {
    -moz-border-radius-topright: 12px;
    -webkit-border-top-right-radius:12px;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabContent {
    background: #fffff;
    min-height: 0;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabContent li {
    display: none;
    padding: 1.4em;
    padding: 3em;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabContent li.$classSettingsTabSelected {
    display: block;
    -webkit-animation: cd-fade-in 0.5s;
    -moz-animation: cd-fade-in 0.5s;
    animation: cd-fade-in 0.5s;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsTabContent li p {
    font-size: 14px;
    font-size: 0.875rem;
    line-height: 1.6;
    color: #8493bf;
    margin-bottom: 2em;
    font-size: 16px;
    font-size: 1rem;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsColorInput input {
    width: 50px;
    padding: 0px 3px;
}
''';
        styleSheet?.insertRule(rule, 0);

        rule =
        '''
.$classSettingsColorInput {
    color: $fontColor;
}
''';
        styleSheet?.insertRule(rule, 0);
    }
}