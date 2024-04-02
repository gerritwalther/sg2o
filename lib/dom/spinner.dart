part of sg2o;

/// Simple element with a spinning circle inside.
class Spinner {
    factory Spinner() => Spinner._internal();

    Spinner._internal();

    Element create() {
        Element spinner = new Element.tag('i')
            ..classes.add(classFontAwesome)
            ..classes.add(classFASpinner)
            ..classes.add(classFASpin)
        ;
        return spinner;
    }
}