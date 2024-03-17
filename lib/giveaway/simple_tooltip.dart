part of sg2o;

/// Tooltip which is shown when hovering over icons in the gridview.
class SimpleTooltip {

    late js.JsObject tooltip;
    late String content;

    bool userContentAdded = false;

    SimpleTooltip(String cssId, String content, Element iconContainer) {
        this.content = content;
        tooltip = js.context.callMethod('\$', ['#$cssId']);

        iconContainer.setAttribute('title', content);
        tooltip.callMethod('powerTip', [new js.JsObject.jsify({
            'placement': 'w',
            'smartPlacement': true,
            'mouseOnToPopup': true,
            'popupId': classProfileTooltipContainer
        })]);
    }
}