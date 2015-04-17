part of sg2o;

class SettingsTabs {

    DivElement tabs;

    SettingsColor colorSettings;
    SettingsCommon commonSettings;
    SettingsGridView gridViewSettings;
    SettingsWishList wishListSettings;

    SettingsTabs(SettingsColor colorSettings, SettingsCommon commonSettings, SettingsGridView gridViewSettings, SettingsWishList wishListSettings) {
        this.colorSettings = colorSettings;
        this.commonSettings = commonSettings;
        this.gridViewSettings = gridViewSettings;
        this.wishListSettings = wishListSettings;
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
        LIElement wishListSettingsListElement = new LIElement();

        Element colorSettingsLink = new Element.a();
        Element commonSettingsLink = new Element.a();
        Element gridViewSettingsLink = new Element.a();
        Element wishListSettingsLink = new Element.a();

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
        wishListSettingsLink
            ..setAttribute('data-content', 'wishlist')
            ..innerHtml = 'WishList'
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
        wishListSettingsListElement
            ..append(wishListSettingsLink)
            ..onClick.listen((Event e) {
                deselectAll();
                wishListSettings.select();
                wishListSettingsLink.classes.add(classSettingsTabSelected);
            })
        ;

        navigationTabs
            ..append(commonSettingsListElement)
            ..append(gridViewSettingsListElement)
            ..append(colorSettingsListElement)
            ..append(wishListSettingsListElement)
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
        LIElement wishListSettingsContentListElement = new LIElement();

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
        wishListSettingsContentListElement
            ..append(wishListSettings.createPage())
            ..setAttribute('data-content', 'wishlist')
        ;

        navigationContent
            ..append(commonSettingsContentListElement)
            ..append(gridViewSettingsContentListElement)
            ..append(colorSettingsContentListElement)
            ..append(wishListSettingsContentListElement)
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