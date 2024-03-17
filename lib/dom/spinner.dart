part of sg2o;

/// Simple element with a spinning circle inside.
class Spinner extends HtmlElement {

    factory Spinner() {
        Element spinner = new Element.tag('i')
            ..classes.add(classFontAwesome)
            ..classes.add(classFASpinner)
            ..classes.add(classFASpin)
        ;
        return spinner as Spinner;
    }
}