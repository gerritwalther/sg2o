part of sg2o;

class MyDom {

}

/// Appends a paragraph [Element] with a style that clears every beforementioned styles to the passed parent [Element].
void addStopStyleParagraph(Element parentElement) {
    parentElement.append(createStopStyleParagraph());
}

/// Creates a [ParagraphElement] and adds a style to clear all current style settings.
Element createStopStyleParagraph() {
    ParagraphElement stopStyles = new ParagraphElement();

    stopStyles.setAttribute('style', 'clear:both;');

    return stopStyles;
}

/// Returns a strong [Element] with specified [content].
Element createStrongElement(content) {
    return createElementWithName('strong', content);
}

/// Returns a text [Element] with specified [content].
Element createTextElement(content) {
    return createElementWithName('text', content);
}

/// Creates an [Element] with a specified tag [name] and a dynamic [content].
Element createElementWithName(String name, content) {
    Element element = new Element.tag(name);
    element.innerHtml = content;
    return element;
}

/// Checks if a pagination is present on the current page.
bool paginationAvailable() {
    return querySelectorAll('.$classPaginationNavigation').isNotEmpty;
}

/// Checks whether is completely visible (vertically) on the current page.
bool isElementCompletelyVisible(Element el) {
    /// credits go to: http://stackoverflow.com/a/7557433/1004795
    /// but without the left/right boundary check.
    var rect = el.getBoundingClientRect();

    return
        rect.top >= 0 &&
//    rect.left >= 0 &&
        rect.bottom <= window.innerHeight + 100 //&&
//    rect.right <= window.innerWidth
    ;
}

/// Returns an [Element] that looks similar to the Giveaways heading.
///
/// The link target is specified with [linkTarget] and its name by [text].
Element createHeading(String text, String linkTarget) {
    DivElement headingContainer = new DivElement();
    DivElement headingText = new DivElement();

    headingText.classes.add(classPageHeadingBreadCrumbs);

    if (linkTarget != null) {
        Element link = new Element.a();
        link
            ..setAttribute('href', linkTarget)
            ..innerHtml = text;
        headingText
            ..append(link);
    } else {
        headingText
            ..innerHtml = text;
    }

    headingContainer
        ..classes.add(classWidgetMarginTop)
        ..classes.add(classSectionHeading)
        ..classes.add(classSg2oTableHeading)
        ..append(headingText);

    return headingContainer;
}

/// Returns [true] if on a page with giveaways. Else returns [false].
bool isOnGAPage() {
    return querySelectorAll('.$classFeaturedOuterWrap').length > 0;
}

/// Returns a simple Option with a checkbox and a function to execute if clicked on.
///
/// * If [yes] is true, the checkbox is checked option is selected.
Element createOption(bool yes, String question, fnCheckboxClick) {
    DivElement formRowIndent = new DivElement();

    DivElement checkboxContainer = createCheckboxContainer('  $question', fnCheckboxClick);

    formRowIndent
        ..classes.add(classFormRowIndent)
        ..append(checkboxContainer);

    if (yes) {
        checkboxContainer.classes.add(classIsSelected);
    } else {
        checkboxContainer.classes.add(classIsDisabled);
    }

    toggleClassOnClick(checkboxContainer, classIsSelected, classIsDisabled);

    return formRowIndent;
}

/// Adds listeners to the two specified elements to switch their classes.
void toggleClassOnClick(DivElement element, String oneClass, String otherClass) {
    addToggleListener(element, oneClass, otherClass);
}

/// Switches the two specified classes on the specified element if clicked on.
void addToggleListener(DivElement element, String oneClass, String otherClass) {
    element.onClick.listen((Event e) {
        if (element.classes.contains(oneClass)) {
            element.classes.remove(oneClass);
            element.classes.add(otherClass);
        } else {
            element.classes.remove(otherClass);
            element.classes.add(oneClass);
        }
    });
}

/// Returns a container which looks like a checkbox with hover functionality and a listener attached.
Element createCheckboxContainer(String optionText, onclickFn) {
    DivElement checkboxContainer = new DivElement();
    Element iElementDefault = new Element.tag('i');
    Element iElementHover = new Element.tag('i');
    Element iElementSelected = new Element.tag('i');

    checkboxContainer
        ..classes.add(classFormCheckbox)
        ..append(iElementDefault)
        ..append(iElementHover)
        ..append(iElementSelected)
        ..appendText(optionText)
        ..onClick.listen(onclickFn);

    iElementDefault.classes.addAll([classFormCheckboxDefault, classFA, classFACircleO]);
    iElementHover.classes.addAll([classFormCheckboxHover, classFA, classFACircle]);
    iElementSelected.classes.addAll([classFormCheckboxSelected, classFA, classFACheckedCircle]);

    return checkboxContainer;
}