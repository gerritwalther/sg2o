part of sg2o;

/// Add user relating stuff here.

/// Returns the users contribution level.
int getUserLevel() {
    Element? navigationPointsElement = querySelector('.$classPoints');
    if (navigationPointsElement != null) {
        return parseNumber(navigationPointsElement.parent?.querySelectorAll('span')[1].getAttribute('title')) ?? 0;
    } else {
        return 0;
    }
}