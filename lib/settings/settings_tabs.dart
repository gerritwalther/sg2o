part of sg2o;

class SettingsTabs {

    DivElement tabs;

    SettingsColor colorSettings;
    SettingsCommon commonSettings;
    SettingsGridView gridViewSettings;

    SettingsTabs(SettingsColor colorSettings, SettingsCommon commonSettings, SettingsGridView gridViewSettings) {
        this.colorSettings = colorSettings;
        this.commonSettings = commonSettings;
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

        LIElement colorSettingsListElement = new LIElement();
        LIElement commonSettingsListElement = new LIElement();
        LIElement gridViewSettingsListElement = new LIElement();

        Element colorSettingsLink = new Element.a();
        Element commonSettingsLink = new Element.a();
        Element gridViewSettingsLink = new Element.a();

        colorSettingsLink
            ..setAttribute('data-content', 'colors')
            ..innerHtml = 'Colors'
        ;
        commonSettingsLink
            ..setAttribute('data-content', 'common')
            ..classes.add(classSettingsTabSelected)
            ..innerHtml = 'Common'
        ;
        gridViewSettingsLink
            ..setAttribute('data-content', 'gridview')
            ..innerHtml = 'GridView'
        ;

        colorSettingsListElement
            ..append(colorSettingsLink)
            ..onClick.listen((Event e) {
                deselectAll();
                colorSettings.select();
                colorSettingsLink.classes.add(classSettingsTabSelected);
            })
        ;
        commonSettingsListElement
            ..append(commonSettingsLink)
            ..onClick.listen((Event e) {
            deselectAll();
                commonSettings.select();
                commonSettingsLink.classes.add(classSettingsTabSelected);
            })
        ;
        gridViewSettingsListElement
            ..append(gridViewSettingsLink)
            ..onClick.listen((Event e) {
                deselectAll();
                gridViewSettings.select();
                gridViewSettingsLink.classes.add(classSettingsTabSelected);
            })
        ;

        navigationTabs
            ..append(commonSettingsListElement)
            ..append(gridViewSettingsListElement)
            ..append(colorSettingsListElement)
        ;
    }

    Element getTabsPage() {
        return tabs;
    }

    void addTabPages() {
        UListElement navigationContent = new UListElement();
        navigationContent.classes.add(classSettingsTabContent);

        LIElement commonSettingsContentListElement = new LIElement();
        LIElement gridViewSettingsContentListElement = new LIElement();
        LIElement colorSettingsContentListElement = new LIElement();

        commonSettingsContentListElement
            ..append(commonSettings.createPage())
            ..classes.add(classSettingsTabSelected)
            ..setAttribute('data-content', 'common')
        ;
        gridViewSettingsContentListElement
            ..append(gridViewSettings.createPage())
            ..setAttribute('data-content', 'gridview')
        ;
        colorSettingsContentListElement
            ..append(colorSettings.createPage())
            ..setAttribute('data-content', 'colors')
        ;

        navigationContent
            ..append(commonSettingsContentListElement)
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