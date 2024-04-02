part of sg2o;

/// Class for settings to this plugin.
class Settings {

    SettingsCommon commonSettings = new SettingsCommon();
    SettingsGridView gridViewSettings = new SettingsGridView();
    SettingsColor colorSettings = new SettingsColor();
    SettingsWishList wishListSettings = new SettingsWishList();
    SettingsTabs? tabSettings;

    Settings() {
        tabSettings = new SettingsTabs(colorSettings, commonSettings, gridViewSettings, wishListSettings);
        Element? body = querySelector('body');
        body?.append(addSettingsPage());
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
            ..innerHtml = 'X'
            ..onClick.listen((e) {
                if (isAutomaticReloadActivated()) {
                    window.location.hash = '#close';
                    window.location.reload();
                }
            })
        ;

        // Header for the settings.
        DivElement heading = new DivElement();
        heading
            ..innerHtml = 'Settings for $pluginName'
            ..classes.add(classSettingsHeading);

        overlayInnerContainer
            ..append(closeLink)
            ..append(heading)
            ..append(tabSettings!.getTabsPage())
        ;

        overlayContainer.append(overlayInnerContainer);
        return overlayContainer;
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

    /// Returns [true] if page should be automatically reloaded after closing the settings.
    bool isAutomaticReloadActivated() {
        return storage.getBool(keyAutomaticPageReload);
    }

    /// Returns [true] if the featured giveaway should be removed.
    bool isFeaturedGAToBeRemoved() {
        return storage.getBool(keyRemoveFeatured);
    }

    /// Returns [true] if the recent discussions should be moved to the top.
    bool isRecentDiscussionsContainerToBeMoved() {
        return storage.getBool(keyMoveRecentDiscussions);
    }

    String getWishListColor() {
        return colorSettings.getColor(wishListColorKey);
    }

    String getWhiteListColor() {
        return colorSettings.getColor(whiteListColorKey);
    }

    String getGroupColor() {
        return colorSettings.getColor(groupColorKey);
    }

    String getContributorAboveColor() {
        return colorSettings.getColor(contributorAboveLevelColorKey);
    }

    String getContributorBelowColor() {
        return colorSettings.getColor(contributorBelowLevelColorKey);
    }
}
