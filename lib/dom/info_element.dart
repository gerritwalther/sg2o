part of sg2o;

class InfoElement {
    factory InfoElement() => InfoElement._internal();

    InfoElement._internal();

    DivElement create(String text) {
        DivElement element = new DivElement();
        element
            ..text = text
        ;
        new Timer(const Duration(seconds: 3), () => element.remove());
        return element;
    }
}