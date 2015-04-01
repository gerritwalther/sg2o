part of sg2o;

class SettingsCommon implements SettingsTab {

    ParagraphElement pageContainer;

    Element createPage() {
        pageContainer = new ParagraphElement();
        pageContainer
            ..append(createAutomaticPageReloadSetting())
            ..append(createRemoveFeaturedSetting())
        ;

        return pageContainer;
    }

    /// Returns an option element for activating/deactivating automatic reload when closing the settings.
    Element createAutomaticPageReloadSetting() {
        return createOption(storage.getBool(keyAutomaticPageReload), 'Automatically reload page when closing settings.', storeAutomaticPageReloadValueToggle);
    }

    /// Returns an option element for removing the featured GA.
    Element createRemoveFeaturedSetting() {
        return createOption(storage.getBool(keyRemoveFeatured), 'Remove featured giveaway.', storeRemoveFeaturedValueToggle);
    }

    /// Function is called when clicking on element to automatically reload page when closing the settings.
    void storeAutomaticPageReloadValueToggle(Event e) {
        settings.storeSettingToggle(e.target, keyAutomaticPageReload);
    }

    /// Function is called when clicking on element for removing featured GA.
    void storeRemoveFeaturedValueToggle(Event e) {
        settings.storeSettingToggle(e.target, keyRemoveFeatured);
    }

    void select() {
        pageContainer.parent.classes.add(classSettingsTabSelected);
    }
}