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
  return querySelectorAll('.pagination').isNotEmpty;
}

bool isElementCompletelyVisible(Element el) {
  int documentViewTop = document.body.scrollTop;
  int documentViewBottom = window.innerHeight + documentViewTop;

  int elementTop = el.offsetTop;
  int elementBottom = elementTop + el.clientHeight;

  return ((elementBottom <= documentViewBottom) && (elementTop >= documentViewTop));
}
