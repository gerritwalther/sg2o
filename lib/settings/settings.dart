part of sg2o;

/// Class for settings to this plugin.
class Settings {

    Settings() {
        Element navigationContainer = querySelector('.$classLeftNavigation');
        Element body = querySelector('body');
        body.append(addSettingsPage());
        navigationContainer.append(addSettingsLink());
    }

    /// Adds a modal layer page.
    Element addSettingsPage() {
        DivElement overlayContainer = new DivElement();
        overlayContainer
            ..id = classSettingsOverlay
            ..classes.add(classModalDialog);

        DivElement overlayInnerContainer = new DivElement();

        Element closeLink = new Element.a();
        closeLink
            ..setAttribute('href', '#close')
            ..title = 'Close'
            ..classes.add(classClose)
            ..innerHtml = 'X';

        DivElement heading = new DivElement();
        heading
            ..innerHtml = 'Settings for $pluginName'
            ..classes.add(classSettingsHeading);

        DivElement formHeading = new DivElement();
        DivElement formHeadingText = new DivElement();

        formHeading
            ..classes.add(classFormHeading)
            ..append(formHeadingText);

        formHeadingText
            ..classes.add(classFormHeadingText)
            ..innerHtml = 'Gridview settings';

        overlayInnerContainer
            ..append(closeLink)
            ..append(heading)
            ..append(formHeading)
            ..append(createHideGASetting())
            ..append(createAutomaticBlackListSetting());

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

    /// Returns an option element for activating/deactivating hiding of entered giveaways.
    Element createHideGASetting() {
        return createOption(storage.getBool(keyHideGAs), 'Hide entered giveaways.', storeHideValueToggle);
    }

    /// Returns an option element for automatically adding games to the blacklist.
    Element createAutomaticBlackListSetting() {
        return createOption(storage.getBool(keyAutomaticBlackList), 'Automatically add games from SG+ filter list to SG blacklist.', storeAutomaticBlackListToggle);
    }

    /// Function is called when clicking on element to hide/show entered giveaways.
    void storeHideValueToggle(Event e) {
        storeSettingToggle(e.target, keyHideGAs);
    }

    /// Function is called when clicking on element to automatically add games to blacklist or not.
    void storeAutomaticBlackListToggle(Event e) {
        storeSettingToggle(e.target, keyAutomaticBlackList);
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
