part of sg2o;

/// Class for the sidebar which is present on most (or all) of the pages
class SideBar {
    int offsetTop;
    Element sidebarElement;

    js.JsObject levelSliderObject;
    js.JsObject pointsSliderObject;
    js.JsObject chanceSliderObject;

    SideBar() {
        sidebarElement = querySelector('.$classSidebar');
    }

    /// Returns [true] if the sidebar is present.
    bool isSidebarPresent() {
        return querySelectorAll('.$classSidebar').length >= 1;
    }

    /// Adds a class to the [SideBar] to fix it.
    void fixSidebar() {
        Element sidebarElement = querySelector('.$classSidebar');
        this.offsetTop = sidebarElement.offset.top;

        window.onScroll.listen(moveSidebar);
        moveSidebar(null);
    }

    /// Moves the sidebar to be always visible and at the same position.
    void moveSidebar(Event e) {
        Element sidebarElement = querySelector('.$classSidebar');

        if (window.scrollY + 39 > offsetTop) {
            /* 25px for the inner page container, 39px for the nav-bar. */
            sidebarElement.setAttribute('style', 'margin-top:' + (25 + 39 + window.scrollY - offsetTop).toString() + 'px;');
        } else {
            sidebarElement.setAttribute('style', 'margin-top: 0px;');
        }
    }

    /// Adds filter elements to the sidebar if a gridview is present.
    void addFilter() {
        DivElement filterContainer = new DivElement();

        DivElement levelSliderContainer = createSlider('sg2o-level-slider', 'Only show giveways in contributor levels range: ');
        DivElement pointsSliderContainer = createSlider('sg2o-points-slider', 'Only show giveways in this points range: ');
        DivElement chanceSliderContainer = createSlider('sg2o-chance-slider', 'Only show giveways in this chance of win range: ');

        filterContainer
            ..append(new SideBarHeading('Giveaway filter'))
            ..append(levelSliderContainer)
            ..append(pointsSliderContainer)
            ..append(chanceSliderContainer)
        ;
        sidebarElement.append(filterContainer);

        levelSliderObject = addSliderJQueryToSlider('sg2o-level-slider', 0, 10, 1, 1, '', _onChange);
        pointsSliderObject = addSliderJQueryToSlider('sg2o-points-slider', 0, 100, 5, 2, '', _onChange);
        chanceSliderObject = addSliderJQueryToSlider('sg2o-chance-slider', 0, 3, 0.1, 5, '%', _onChange);
    }

    /// Moves the ads to the end of all elements in the sidebar. Preferably call after `addFilter`.
    void moveAdsToTheEnd() {
        Node adsElement = sidebarElement.querySelector('.sidebar__mpu');
        sidebarElement.append(adsElement);
    }

    /// Creates a [DivElement] containing another [DivElement] used as slider Object with corresponding [label].
    DivElement createSlider(String id, String label) {
        DivElement slider = new DivElement()
            ..id = id
        ;
        DivElement sliderContainer = new DivElement()
            ..text = label
            ..style.setProperty('font-size', '11px')
            ..style.setProperty('padding-bottom', '12px')
            ..append(slider)
        ;

        return sliderContainer;
    }

    /// Adds a jQuery Slider to the [Element] defined by [id].
    js.JsObject addSliderJQueryToSlider(String id, num min, num max, num steps, num pipSteps, String suffix, fnOnChange) {
        js.JsObject resultSlider = js.context.callMethod('\$', ['#$id']);

        // Add jQuery Slider
        resultSlider.callMethod('slider', [new js.JsObject.jsify({
            'min': min,
            'max': max,
            'step': steps,
            'range': true,
            'values': [min, max]
        })]);

        // Add pips to the Slider (lines below the slider)
        resultSlider.callMethod('slider', ['pips', new js.JsObject.jsify({
            'first': 'label',
            'last': 'label',
            'rest': 'label',
            'step': pipSteps,
            'suffix': suffix
        })]);

        // Add a floating tooltip to the handles.
        resultSlider.callMethod('slider', ['float', new js.JsObject.jsify({
            'handle': true
        })]);

        resultSlider.callMethod('on', ['slidechange', fnOnChange]);

        return resultSlider;
    }

    /// Called when a slider position changes. Hides any giveaways that does not correspond to the ranges.
    void _onChange(js.JsObject obj1, js.JsObject obj2) {
        num fromLevel = levelSliderObject.callMethod('slider', ['values', 0]);
        num toLevel = levelSliderObject.callMethod('slider', ['values', 1]);
        num fromPoints = pointsSliderObject.callMethod('slider', ['values', 0]);
        num toPoints = pointsSliderObject.callMethod('slider', ['values', 1]);
        num fromChance = chanceSliderObject.callMethod('slider', ['values', 0]);
        num toChance = chanceSliderObject.callMethod('slider', ['values', 1]);
        gridView.hideTemporarilyByRanges(fromLevel, toLevel, fromPoints, toPoints, fromChance, toChance);
    }
}