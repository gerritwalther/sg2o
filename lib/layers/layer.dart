part of sg2o;

/// Abstract class for layers.
abstract class Layer {

    Element body;

    Layer() {
        body = querySelector('body');
        instantiateLayer();
    }

    /// This will be called when the class is constructed. Should add layer and link.
    void instantiateLayer();

    /// Adds a modal layer. The [layerId] has to be the same as the link to this Layer.
    Element createLayer(String layerId);

    DivElement createLayerContainer();

    Element createCloseLink() {
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

        return closeLink;
    }

    /// Returns [true] if page should be automatically reloaded after closing the settings.
    bool isAutomaticReloadActivated() {
        return storage.getBool(keyAutomaticPageReload);
    }

    DivElement createHeading(String title) {
        DivElement heading = new DivElement();
        heading
            ..innerHtml = title
            ..classes.add(classSectionHeading)
            ..classes.add(classSettingsHeading)
        ;

        return heading;
    }
}