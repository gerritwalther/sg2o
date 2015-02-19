part of sg2o;

class MyDom {

}

void addStopStyleParagraph(Element parentElement) {
  parentElement.append(createStopStyleParagraph());
}

Element createStopStyleParagraph() {
  ParagraphElement stopStyles = new ParagraphElement();

  stopStyles.setAttribute('style', 'clear:both;');

  return stopStyles;
}

Element createStrongElement(content) {
  return createElementWithName('strong', content);
}

Element createTextElement(content) {
  return createElementWithName('text', content);
}

Element createElementWithName(String name, content) {
  Element element = new Element.tag(name);
  element.innerHtml = content;
  return element;
}

bool paginationAvailable() {
  return querySelectorAll('.$classPaginationNavigation').isNotEmpty;
}

bool isElementCompletelyVisible(Element el) {
  int documentViewTop = document.body.scrollTop;
  int documentViewBottom = window.innerHeight + documentViewTop;

  int elementTop = el.offsetTop;
  int elementBottom = elementTop + el.clientHeight;

  return ((elementBottom <= documentViewBottom) && (elementTop >= documentViewTop));
}

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
    ..classes.add(classSectionHeading)
    ..classes.add(classSg2oTableHeading)
    ..append(headingText);

  return headingContainer;
}

bool isOnGAPage () {
  return querySelectorAll('.$classFeaturedOuterWrap').length > 0;
}

Element createOption(bool yes, String question, fnYes, fnNo) {
  DivElement booleanContainerOption = new DivElement();

  DivElement formHeading = new DivElement();
  DivElement formHeadingText = new DivElement();

  DivElement formRowIndent = new DivElement();

  DivElement checkboxYesContainer = createCheckboxContainer(' Yes', fnYes);

  DivElement checkboxNoContainer = createCheckboxContainer(' No', fnNo);

  booleanContainerOption
    ..classes.add(classFormRow)
    ..append(formHeading)
    ..append(formRowIndent);

  formHeading
    ..classes.add(classFormHeading)
    ..append(formHeadingText);

  formHeadingText
    ..classes.add(classFormHeadingText)
    ..innerHtml = question;

  formRowIndent
    ..classes.add(classFormRowIndent)
    ..append(checkboxYesContainer)
    ..append(checkboxNoContainer);

  if (yes) {
    checkboxYesContainer.classes.add(classFormIsSelected);
    checkboxNoContainer.classes.add(classFormIsDisabled);
  } else {
    checkboxNoContainer.classes.add(classFormIsSelected);
    checkboxYesContainer.classes.add(classFormIsDisabled);
  }

  toggleClassesOnClick(checkboxYesContainer, checkboxNoContainer, classFormIsSelected, classFormIsDisabled);

  return booleanContainerOption;
}

void toggleClassesOnClick(DivElement yesCheckbox, DivElement noCheckBox, String oneClass, String otherClass) {
  addToggleListener(yesCheckbox, noCheckBox, oneClass, otherClass);
  addToggleListener(noCheckBox, yesCheckbox, oneClass, otherClass);
}

addToggleListener(DivElement oneElement, DivElement otherElement, String oneClass, String otherClass) {
  oneElement.onClick.listen((Event e) {
    if (oneElement.classes.contains(oneClass)) {
      oneElement.classes.remove(oneClass);
      otherElement.classes.remove(otherClass);

      oneElement.classes.add(otherClass);
      otherElement.classes.add(oneClass);
    } else {
      oneElement.classes.remove(otherClass);
      otherElement.classes.remove(oneClass);

      oneElement.classes.add(oneClass);
      otherElement.classes.add(otherClass);
    }
  });
}

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