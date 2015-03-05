part of sg2o;

/// Class for settings to this plugin.
class Settings {

    SettingsColor colorSettings = new SettingsColor();
    SettingsGridView gridViewSettings = new SettingsGridView();
    SettingsTabs tabSettings;

    Settings() {
        tabSettings = new SettingsTabs(colorSettings, gridViewSettings);
        Element body = querySelector('body');
        body.append(addSettingsPage());
        Element navigationContainer = querySelector('.$classLeftNavigation');
        navigationContainer.append(addSettingsLink());
    }

    /// Adds a modal layer page.
    Element addSettingsPage() {
        // Fullscreen overlay
        DivElement overlayContainer = new DivElement();
        overlayContainer
            ..id = classSettingsOverlay
            ..classes.add(classModalDialog);

        // only the settings menu (without the background
        DivElement overlayInnerContainer = new DivElement();

        Element closeLink = new Element.a();
        closeLink
            ..setAttribute('href', '#close')
            ..title = 'Close'
            ..classes.add(classClose)
            ..innerHtml = 'X';

        // Header for the settings.
        DivElement heading = new DivElement();
        heading
            ..innerHtml = 'Settings for $pluginName'
            ..classes.add(classSettingsHeading);

        overlayInnerContainer
            ..append(closeLink)
            ..append(heading)
            ..append(tabSettings.getTabsPage())
        ;

        overlayContainer.append(overlayInnerContainer);
        return overlayContainer;
    }

    /// Adds a link to the navbar on SG.
    Element addSettingsLink() {
        String name = pluginName;
        Element navigationButton = new Element.a();
        navigationButton
            ..classes.add(classNavigationButton)
            ..setAttribute('href', '#$classSettingsOverlay')
            ..text = name;

        DivElement navigationButtonContainer = new DivElement();
        navigationButtonContainer
            ..classes.add(classNavigationButtonContainer)
            ..append(navigationButton);

        return navigationButtonContainer;
    }

    /// Toggles the status of the setting.
    void storeSettingToggle(Element optionElement, String storageKey) {
        if (optionElement.classes.contains(classIsSelected)) {
            storage.add(storageKey, 'false');
        } else {
            storage.add(storageKey, 'true');
        }
    }

    /// Returns [true] if entered games should be hidden.
    bool hideEnteredGames() {
        return storage.getBool(keyHideGAs);
    }

    /// Returns [true] if games should be automatically blacklisted.
    bool isAutomaticBlackListingOn() {
        return storage.getBool(keyAutomaticBlackList);
    }
}
