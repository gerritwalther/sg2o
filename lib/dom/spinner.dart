part of sg2o;

/// Simple element with a spinning circle inside.
class Spinner extends HtmlElement {

    factory Spinner() {
        Element spinner = new Element.tag('i')
            ..classes.add(classFASpinner)
            ..classes.add(classFASpin)
            ..classes.add(classFontAwesome);
        return spinner;
    }
}