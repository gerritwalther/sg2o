part of sg2o;

/// Class for displaying a layer with about information.
class LayerAbout extends Layer {

    LayerAbout() : super();

    @override
    Element createLayer(String layerId) {
        // Fullscreen overlay
        DivElement overlayContainer = new DivElement();
        overlayContainer
            ..id = layerId
            ..classes.add(classModalDialog)
        ;

        DivElement overlayInnerContainer = createLayerContainer();

        Element closeLink = createCloseLink();

        overlayInnerContainer
            ..append(closeLink)
        ;

        overlayContainer.append(overlayInnerContainer);
        return overlayContainer;
    }

    @override
    DivElement createLayerContainer() {
        DivElement innerContainer = new DivElement()
            ..classes.add(classPageOuterWrap)
            ..classes.add('markdown')
        ;

        DivElement heading = this.createHeading('About ${pluginName}');

        UListElement body = new UListElement()
            ..classes.add(classSectionDescription)
        ;

        LIElement description = new LIElement()
            ..setInnerHtml('This is a plugin to enhance the experience on Steamgifts (V2). It implements features from the previously known script sg+.')
        ;

        LIElement discussion = new LIElement()
            ..setInnerHtml('If you have questions join the <a href="https://www.steamgifts.com/discussion/1bv93/">discussion</a> on the forum.')
        ;

        LIElement bugs = new LIElement()
            ..setInnerHtml('Found bugs? Report them in the <a href="https://www.steamgifts.com/discussion/1bv93/">discussion</a>.')
        ;

        body
            ..append(description)
            ..append(discussion)
            ..append(bugs)
        ;

        innerContainer
            ..append(heading)
            ..append(body)
        ;

        return innerContainer;
    }

    @override
    void instantiateLayer() {
        body.append(createLayer(classSG2OAboutLink));
    }
}