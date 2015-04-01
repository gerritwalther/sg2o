part of sg2o;

class InfoElement extends DivElement {

    DivElement element;

    factory InfoElement(String text) {
        DivElement element = new DivElement();
        element
            ..text = text
            ..setAttribute('is', 'my-info-div')
        ;
        new Timer(const Duration(seconds: 3), () => element.remove());
        return element;
    }
}