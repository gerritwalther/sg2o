part of sg2o;

/// Simple element with a spinning circle inside.
class FAElement {

    factory FAElement() => FAElement._internal();

    FAElement._internal();

    Element create(faClass) {
        Element faElement = new Element.tag('i')
            ..classes.add(classFontAwesome)
            ..classes.add(faClass)
        ;
        return faElement;
    }
}