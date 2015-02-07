part of sg2o;

class Styles {

  CssStyleSheet styleSheet;

  Styles () {
    styleSheet = createStyleSheetElement();
  }

  void addStyles() {
    new BorderStyles().addBorderStyles();
    new CommonStyles().addStyles();
  }

  CssStyleSheet createStyleSheetElement() {
    StyleElement styles = new StyleElement();
    document.head.append(styles);

    return styles.sheet;
  }

  void addMarginToHeader() {
    Element headerElement = querySelector('.page__heading');

    headerElement.setAttribute('style', 'margin-bottom: 0.5em');
  }

}