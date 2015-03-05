part of sg2o;

class SettingsTabs {

    DivElement tabs;
    SettingsColor colorSettings;
    SettingsGridView gridViewSettings;

    SettingsTabs(SettingsColor colorSettings, SettingsGridView gridViewSettings) {
        this.colorSettings = colorSettings;
        this.gridViewSettings = gridViewSettings;
        tabs = new DivElement();
        tabs.classes.add(classSettingsTabs);
        addTabMenu();
        addTabPages();
    }

    void addTabMenu() {
        // Navigation
        Element navigation = new Element.tag('nav');

        tabs.append(navigation);

        UListElement navigationTabs = new UListElement();
        navigationTabs.classes.add(classSettingsTabMenu);

        navigation.append(navigationTabs);

        LIElement gridViewSettingsListElement = new LIElement();
        LIElement colorSettingsListElement = new LIElement();

        Element gridViewSettingsLink = new Element.a();
        Element colorSettingsLink = new Element.a();

        gridViewSettingsLink
            ..setAttribute('data-content', 'gridview')
            ..classes.add(classSettingsTabSelected)
            ..innerHtml = 'GridView'
        ;
        colorSettingsLink
            ..setAttribute('data-content', 'colors')
            ..innerHtml = 'Colors'
        ;

        gridViewSettingsListElement
            ..append(gridViewSettingsLink)
            ..onClick.listen((Event e) {
                deselectAll();
                gridViewSettings.select();
                gridViewSettingsLink.classes.add(classSettingsTabSelected);
            })
        ;
        colorSettingsListElement
            ..append(colorSettingsLink)
            ..onClick.listen((Event e) {
                deselectAll();
                colorSettings.select();
                colorSettingsLink.classes.add(classSettingsTabSelected);
            })
        ;

        navigationTabs
            ..append(gridViewSettingsListElement)
            ..append(colorSettingsListElement);
    }

    Element getTabsPage() {
        return tabs;
    }

    void addTabPages() {
        UListElement navigationContent = new UListElement();
        navigationContent.classes.add(classSettingsTabContent);

        LIElement gridViewSettingsContentListElement = new LIElement();
        LIElement colorSettingsContentListElement = new LIElement();

        gridViewSettingsContentListElement
            ..append(gridViewSettings.createPage())
            ..classes.add(classSettingsTabSelected)
            ..setAttribute('data-content', 'gridview')
        ;
        colorSettingsContentListElement
            ..append(colorSettings.createPage())
            ..setAttribute('data-content', 'colors')
        ;

        navigationContent
            ..append(gridViewSettingsContentListElement)
            ..append(colorSettingsContentListElement)
        ;

        tabs.append(navigationContent);
    }

    void deselectAll() {
        ElementList selectedTabsAndContent = querySelectorAll('.$classSettingsTabSelected');

        selectedTabsAndContent.forEach((Element e) {
            e.classes.remove(classSettingsTabSelected);
        });
    }

}