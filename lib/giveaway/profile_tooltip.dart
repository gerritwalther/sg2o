part of sg2o;

/// Tooltip which is shown when hovering over user avatars.
class ProfileTooltip {

    DomParser domParser = new DomParser();
    String userName;
    js.JsObject tooltip;
    bool userContentAdded = false;

    ProfileTooltip(String cssId, String userName, Element avatarContainer) {
        this.userName = userName;
        tooltip = js.context.callMethod('\$', ['#$cssId']);

        avatarContainer.setAttribute('data-powertip', createSpinner());
        tooltip.callMethod('powerTip', [new js.JsObject.jsify({
            'placement': 'e',
            'smartPlacement': true,
            'mouseOnToPopup': true,
            'popupId': classProfileTooltipContainer
        })]);
    }

    /// Returns string form of a Spinner.
    String createSpinner() {
        return new Spinner().outerHtml;
    }

    /// Requests the profile content once from the users profile and adds it to the tooltip.
    void addUserContent() {
        if (!userContentAdded) {
            userContentAdded = true;
            HttpRequest.request('/user/$userName').then((HttpRequest resp) {
                Document nextPageDocument = domParser.parseFromString(resp.responseText, 'text/html');

                DivElement container = new DivElement()
                    ..setInnerHtml(nextPageDocument.querySelector('.featured__outer-wrap--user>.featured__inner-wrap>.featured__summary').outerHtml)
                    ..classes.add('$classProfileTooltip')
                ;

                return container.outerHtml;
            }).then((String result) {
                querySelector('#$classProfileTooltipContainer').setInnerHtml(result);
                tooltip.callMethod('data', ['powertip', result]);
            });
        }
    }
}