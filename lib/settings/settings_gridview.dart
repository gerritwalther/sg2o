part of sg2o;

class SettingsGridView implements SettingsTab {

    ParagraphElement pageContainer;

    SettingsGridView() {

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
        settings.storeSettingToggle(e.target, keyHideGAs);
    }

    /// Function is called when clicking on element to automatically add games to blacklist or not.
    void storeAutomaticBlackListToggle(Event e) {
        settings.storeSettingToggle(e.target, keyAutomaticBlackList);
    }

    Element createPage() {
        pageContainer = new ParagraphElement();
        pageContainer
            ..append(createHideGASetting())
            ..append(createAutomaticBlackListSetting())
        ;

        return pageContainer;
    }

    void select() {
        pageContainer.parent.classes.add(classSettingsTabSelected);
    }

}