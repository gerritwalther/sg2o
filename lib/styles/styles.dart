part of sg2o;

class Styles {

    CssStyleSheet styleSheet;

    Styles() {
        styleSheet = createStyleSheetElement();
    }

    void addStyles() {
        new BorderStyles().addBorderStyles();
        new CommonStyles().addStyles();
        new SettingsStyles().addStyles();
    }

    CssStyleSheet createStyleSheetElement() {
        StyleElement styles = new StyleElement();
        document.head.append(styles);

        return styles.sheet;
    }

    void addMarginToHeader() {
        Element headerElement = querySelector('.$classSectionHeading');

        headerElement.setAttribute('style', 'margin-bottom: 0.5em');
    }

}