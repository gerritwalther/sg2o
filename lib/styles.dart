part of sg2o;

void addStylesToHeader() {
  CssStyleSheet styleSheet = createStyleSheetElement();

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
  width: 184px;
  margin-left: 1%;
  margin-right: 1%;
  border-radius: 2px;
  margin-bottom: 0.5em;
}
''';

  styleSheet.insertRule(rule, 0);

  rule =
'''
.page__heading {
  margin-bottom: 0.5em;
}
''';

  styleSheet.insertRule(rule, 0);

  rule =
'''
.gridview-info {
  z-index: 100;
  font-size: 10;
  border: 1px solid #d2d6e0;
  width: inherit;
  margin-top: -5px;
  border-radius: 3px;
  padding: 5px;
  background: white;
  position: absolute;
}
''';

  styleSheet.insertRule(rule, 0);

  rule =
'''
.gridview-avatar {
  width: 25px;
  height: 25px;
  padding: 2px;
  border: 1px solid #d2d6e0;
  border-radius: 1px;
}
''';

  styleSheet.insertRule(rule, 0);

  rule =
'''
.float-left {
  float: left;
}
''';

  styleSheet.insertRule(rule, 0);

  rule =
'''
.float-right {
  float: right;
}
''';

  styleSheet.insertRule(rule, 0);

  rule =
'''
.ga-name {
  font-weight: bold;
  min-height: 30px;
  margin-bottom: 0.5em;
}
''';

  styleSheet.insertRule(rule, 0);

  rule =
'''
.hidden {
  display: none !important;
}
''';

  styleSheet.insertRule(rule, 0);

  rule =
'''
.faded {
  opacity: 0.5;
}
''';

  styleSheet.insertRule(rule, 0);

  addBorderStyles();
}

CssStyleSheet createStyleSheetElement() {
  StyleElement styles = new StyleElement();
  document.head.append(styles);

  return styles.sheet;
}

void addStopStyleParagraph(Element parentElement) {
  Element stopStyles = new ParagraphElement();

  stopStyles.setAttribute('style', 'clear:both;');

  parentElement.append(stopStyles);
}

Element createStopStyleParagraph() {
  ParagraphElement stopStyles = new ParagraphElement();

  stopStyles.setAttribute('style', 'clear:both;');

  return stopStyles;
}

Element createStrongElement(content) {
  return createElementWithName('strong', content);
}

Element createTextElement(content) {
  return createElementWithName('text', content);
}

Element createElementWithName(String name, content) {
  Element element = new Element.tag(name);
  element.innerHtml = content;
  return element;
}

void addMarginToHeader() {
  Element headerElement = querySelector('.page__heading');

  headerElement.setAttribute('style', 'margin-bottom: 0.5em');
}