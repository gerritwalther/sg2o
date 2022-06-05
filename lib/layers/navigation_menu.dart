part of sg2o;

class NavigationMenu {

    Element _navigationTopBar = querySelector('.$classLeftNavigation');
    DivElement _absoluteDropDown;
    DivElement _relativeDropDown;

    static final NavigationMenu _navigationMenu = new NavigationMenu._internal();

    factory NavigationMenu() {
        return _navigationMenu;
    }

    NavigationMenu._internal() {
        _navigationTopBar.querySelectorAll('.$classNavigationButtonContainer').last.insertAdjacentElement('beforebegin', _createMenuEntry());
        addDropDownEntry(createDropDownEntry(classSettingsOverlay, 'fa-cog', 'Settings', 'Change settings for SG2O', 'icon-green'));
        addDropDownEntry(createDropDownEntry(classSG2OAboutLink, 'fa-info-circle', 'About the plugin', 'Information about the plugin.', 'icon-blue'));
    }

    /// Creates a menu entry to the navigation bar of SG with a dropdown arrow.
    Node _createMenuEntry() {
        DivElement navigationButtonContainer = new DivElement();
        navigationButtonContainer.classes.add(classNavigationButtonContainer);

        _relativeDropDown = new DivElement();
        _relativeDropDown.classes.add(classNavigationRelativeDropDown);
        _relativeDropDown.classes.add(classIsHidden);

        _absoluteDropDown = new DivElement();
        _absoluteDropDown.classes.add(classNavigationAbsoluteDropDown);

        _relativeDropDown.append(_absoluteDropDown);

        Element infoLayer = new Element.a();
        infoLayer.classes
            ..add(classNavigationButton)
            ..add(classNavigationButtonIsDropDown)
        ;
        infoLayer.setAttribute('href', '/discussion/1bv93/');
        infoLayer.setInnerHtml('SG₂O');

        navigationButtonContainer
            ..append(_relativeDropDown)
            ..append(infoLayer)
            ..append(createDropDownArrow())
        ;

        return navigationButtonContainer;
    }

    /// Call this function to create a dropdown entry with the [link], [faIcon], [title] and [description].
    Node createDropDownEntry(String link, String faIcon, String title, String description, String iconColor) {
        Element linkElement = new Element.a();
        linkElement.classes.add(classNavigationRow);
        linkElement.setAttribute('href', '#$link');

        FAElement iconElement = new FAElement();
        iconElement.classes.add('fa-fw');
        iconElement.classes.add(faIcon);
        iconElement.classes.add(iconColor);

        DivElement content = new DivElement();
        content.classes.add(classNavigationRowSummary);

        ParagraphElement nameElement = new ParagraphElement();
        nameElement.classes.add(classNavigationRowSummaryName);
        nameElement.setInnerHtml(title);

        ParagraphElement descriptionElement = new ParagraphElement();
        descriptionElement.classes.add(classNavigationRowSummaryDescription);
        descriptionElement.setInnerHtml(description);

        content
            ..append(nameElement)
            ..append(descriptionElement)
        ;

        linkElement
            ..append(iconElement)
            ..append(content)
        ;

        return linkElement;
    }

    /// Call this function to add an entry to the dropdown menu.
    void addDropDownEntry(Node entry) {
        _absoluteDropDown.append(entry);
    }

    /// Creates a Node with a Dropdown arrow.
    Node createDropDownArrow() {
        DivElement dropDownArrow = new DivElement();
        dropDownArrow.classes
            ..add(classNavigationButton)
            ..add(classNavigationButtonIsDropDownArrow)
        ;

        dropDownArrow.onClick.listen((e) {
            dropDownArrow.classes.toggle(classIsSelected);
            _relativeDropDown.classes.toggle(classIsHidden);
            e.stopImmediatePropagation();
        });

        FAElement faElement = new FAElement();
        faElement.classes.add(classFAAngleDown);

        dropDownArrow.append(faElement);

        return dropDownArrow;
    }
}


