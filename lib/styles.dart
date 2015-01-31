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
}