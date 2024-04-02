part of sg2o;

class SettingsColor implements SettingsTab {

    late ParagraphElement pageContainer;

    ColorSetting wishlistColorSetting = new ColorSetting('Wishlist border color: ', wishListColorKey);
    ColorSetting groupColorSetting = new ColorSetting('Group border color: ', groupColorKey);
    ColorSetting whitelistColorSetting = new ColorSetting('Whitelist border color: ', whiteListColorKey);
    ColorSetting contributorAboveLevelColorSetting = new ColorSetting('Contributor (above own level) border color: ', contributorAboveLevelColorKey);
    ColorSetting contributorBelowLevelColorSetting = new ColorSetting('Contributor (below own level) border color: ', contributorBelowLevelColorKey);

    Element createPage() {
        DivElement saveButton = SGButton().create('fa-arrow-circle-right', 'Save colors!', this.storeColors);

        saveButton
            ..style.setProperty('margin-right', '5px')
        ;

        DivElement restoreDefaultsButton = SGButton().create('fa-trash', 'Restore defaults', this.restoreDefaultColors);

        pageContainer = new ParagraphElement();

        pageContainer
            ..append(wishlistColorSetting.getContainer())
            ..append(groupColorSetting.getContainer())
            ..append(whitelistColorSetting.getContainer())
            ..append(contributorAboveLevelColorSetting.getContainer())
            ..append(contributorBelowLevelColorSetting.getContainer())
            ..append(saveButton)
            ..append(restoreDefaultsButton)
        ;

        return pageContainer;
    }

    void storeColors(MouseEvent e) {
        wishlistColorSetting.store();
        groupColorSetting.store();
        whitelistColorSetting.store();
        contributorAboveLevelColorSetting.store();
        contributorBelowLevelColorSetting.store();

        pageContainer.append(InfoElement().create('Colors stored!'));
    }

    void restoreDefaultColors(MouseEvent e) {
        wishlistColorSetting.restoreDefault();
        groupColorSetting.restoreDefault();
        whitelistColorSetting.restoreDefault();
        contributorAboveLevelColorSetting.restoreDefault();
        contributorBelowLevelColorSetting.restoreDefault();

        pageContainer.append(InfoElement().create('Default values restored!'));
    }

    /// Called when the tab for this settings page is clicked.
    void select() {
        pageContainer.parent?.classes.add(classSettingsTabSelected);
    }

    String getColor(String key) {
        String result = '';
        switch (key) {
            case wishListColorKey:
                result = wishlistColorSetting.loadColor();
                break;
            case whiteListColorKey:
                result = whitelistColorSetting.loadColor();
                break;
            case groupColorKey:
                result = groupColorSetting.loadColor();
                break;
            case contributorAboveLevelColorKey:
                result = contributorAboveLevelColorSetting.loadColor();
                break;
            case contributorBelowLevelColorKey:
                result = contributorBelowLevelColorSetting.loadColor();
                break;
            default:
                break;
        }
        return result;
    }
}