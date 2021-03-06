part of sg2o;

/// Main class for adding all the styles required for the plugin.
class Styles {

    CssStyleSheet styleSheet;

    Styles() {
        styleSheet = createStyleSheetElement();
    }

    /// Adds all styles. Add more here.
    void addStyles() {
        new BorderStyles().addBorderStyles();
        new CommonStyles().addStyles();
        new SettingsStyles().addStyles();
        new Tooltip().addStyles();
    }

    /// Creates a [StyleElement] and adds it to the DOM.
    CssStyleSheet createStyleSheetElement() {
        StyleElement styles = new StyleElement();
        document.head.append(styles);

        return styles.sheet;
    }

    /// Adds a margin to the header.
    void addMarginToHeader() {
        Element headerElement = querySelector('.$classSectionHeading');

        headerElement.setAttribute('style', 'margin-bottom: 0.5em');
    }

}