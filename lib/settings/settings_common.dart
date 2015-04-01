part of sg2o;

class SettingsCommon implements SettingsTab {

    ParagraphElement pageContainer;

    Element createPage() {
        pageContainer = new ParagraphElement();
        pageContainer
            ..append(createAutomaticPageReloadSetting())
        ;

        return pageContainer;
    }

    /// Returns an option element for activating/deactivating automatic reload when closing the settings.
    Element createAutomaticPageReloadSetting() {
        return createOption(storage.getBool(keyAutomaticPageReload), 'Automatically reload page when closing settings.', storeAutomaticPageReloadValueToggle);
    }

    /// Function is called when clicking on element to automatically reload page when closing the settings.
    void storeAutomaticPageReloadValueToggle(Event e) {
        settings.storeSettingToggle(e.target, keyAutomaticPageReload);
    }

    void select() {
        pageContainer.parent.classes.add(classSettingsTabSelected);
    }
}