part of sg2o;

/// Simple element with a spinning circle inside.
class FAElement extends HtmlElement {

    factory FAElement() {
        Element faElement = new Element.tag('i')
            ..classes.add(classFontAwesome)
        ;
        return faElement as FAElement;
    }
}