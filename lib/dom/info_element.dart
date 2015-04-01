part of sg2o;

class InfoElement extends DivElement {

    factory InfoElement(String text) {
        DivElement element = new DivElement();
        element
            ..text = text
        ;
        new Timer(const Duration(seconds: 3), () => element.remove());
        return element;
    }
}