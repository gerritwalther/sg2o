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

        overlayInnerContainer
            ..append(closeLink)
            ..append(heading)
            ..append(createHideGASetting());

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
        return createOption(storage.getBool(keyHideGAs), 'Hide entered giveaways?', storeHideValueYes, storeHideValueNo);
    }

    /// Function is called when clicking on element to hide entered giveaways.
    void storeHideValueYes(Event e) {
        storage.add(keyHideGAs, 'true');
    }

    /// Function is called when clicking on element to show entered giveaways.
    void storeHideValueNo(Event e) {
        storage.add(keyHideGAs, 'false');
    }
}
