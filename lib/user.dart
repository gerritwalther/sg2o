part of sg2o;

int getUserLevel() {
    Element navigationPointsElement = querySelector('.$classPoints');
    if (navigationPointsElement != null) {
        return parseNumber(navigationPointsElement.parent.querySelectorAll('span')[1].getAttribute('title'));
    } else {
        return 0;
    }
}