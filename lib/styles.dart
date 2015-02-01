part of SGv2plus;

void addStylesToHeader() {
  StyleElement styles = new StyleElement();
  document.head.append(styles);

  CssStyleSheet styleSheet = styles.sheet;

  String rule =
'''
body {
  margin-top: 39px;
}
''';

  styleSheet.insertRule(rule, 0);

  rule =
'''
.fixed-navigation-bar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 9999;
  width: 100%;
}
''';

  styleSheet.insertRule(rule, 0);

  rule =
'''
.giveaway-gridview {
  float: left;
  width: 18%;
  margin-right: 1%;
  margin-left: 1%;
  margin-bottom: 0.5em;
}
''';

  styleSheet.insertRule(rule, 0);
}