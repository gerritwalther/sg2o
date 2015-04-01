part of sg2o;

class SGButton extends DivElement {

    factory SGButton(String faClass, String text, fnButtonListener) {
        DivElement element = new DivElement();
        element
            ..classes.add('fa')
            ..classes.add(faClass)
            ..classes.add('form__submit-button')
            ..style.setProperty('margin-top', '10px')
            ..text = ' $text'
            ..onClick.listen(fnButtonListener)
        ;
        return element;
    }
}

