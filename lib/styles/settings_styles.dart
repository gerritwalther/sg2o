part of sg2o;

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
  z-index: 9999;
  opacity: 0;
  -webkit-transition: opacity 400ms ease-in;
  -moz-transition: opacity 400ms ease-in;
  transition: opacity 400ms ease-in;
  pointer-events: none;
}
''';
        styleSheet.insertRule(rule, 0);

        rule =
        '''
.$classModalDialog:target {
  opacity: 1;
  pointer-events: auto;
}
''';
        styleSheet.insertRule(rule, 0);

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
        styleSheet.insertRule(rule, 0);

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
        styleSheet.insertRule(rule, 0);

        rule =
        '''
.$classClose:hover {
  background: #00d9ff;
}
''';
        styleSheet.insertRule(rule, 0);

        rule =
        '''
.$classSettingsHeading {
  font: 700 20px "Open Sans", sans-serif;
  color: $fontColor;
}
''';
        styleSheet.insertRule(rule, 0);
    }
}