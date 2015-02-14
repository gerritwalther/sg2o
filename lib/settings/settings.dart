part of sg2o;

class Settings {

  Settings () {
    Element navigationContainer = querySelector('.$classLeftNavigation');
    Element body = querySelector('body');
    body.append(addSettingsPage());
    navigationContainer.append(addSettingsLink());
  }

  Element addSettingsPage () {
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

    Element heading = new Element.tag('h2');
    heading.innerHtml = 'Modal Box';

    ParagraphElement pEl = new ParagraphElement();
    pEl.innerHtml = 'This is just a test';

    overlayInnerContainer
      ..append(closeLink)
      ..append(heading)
      ..append(pEl);

    overlayContainer.append(overlayInnerContainer);
    return overlayContainer;
  }

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
}