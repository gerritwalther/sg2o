part of SGv2plus;

class GiveAway {
  String name;
  String created;
  String creator;
  String remaining;
  Element imageWithLink;
  int points;
  int entries;
  int copies = 1;
  int comments;
  String link;
  
  GiveAway(Element gaHtml) {
    ElementList copiesAndPoints = gaHtml.querySelectorAll('span.giveaway__heading__thin');
    Element copies;
    Element points;
    if (copiesAndPoints.length == 1) {
      points = copiesAndPoints[0];
    } else {
      copies = copiesAndPoints[0];
      points = copiesAndPoints[1];
      this.copies = parseNumber(copies.text);
    }
    this.points = parseNumber(points.text);
    Element nameAndLink = gaHtml.querySelector('a.giveaway__heading__name');
    this.name = nameAndLink.text;
    this.link = nameAndLink.getAttribute('href');
    this.remaining = parseTime(gaHtml.querySelector('div.giveaway__columns>div>span').text);
    this.created = parseTime(gaHtml.querySelector('div.giveaway__column--width-fill').text);
    this.creator = gaHtml.querySelector('div.giveaway__column--width-fill').text.split(" ")[4];
    ElementList entriesAndComments = gaHtml.querySelectorAll('div.giveaway__links>a>span');
    this.entries = parseNumber(entriesAndComments.first.text);
    this.comments = parseNumber(entriesAndComments.last.text);
    this.imageWithLink = gaHtml.querySelector('global__image-outer-wrap');
  }
  
  void print() {
    window.console.info(toString());
  }
  
  String toString() {
    return "Giveaway: " + name + " with " + points.toString() + " Points, created by " + creator + " " + created + " ago,  still open for: " + remaining + ", has " + entries.toString() + " entries and " + comments.toString() + " comments, link: " + link;
  }
  
  // Extract the following somewhere else
  int parseNumber(String stringWithNumber) {
    var regexp = new RegExp(r'\d+');
    int number = int.parse(regexp.allMatches(stringWithNumber.replaceAll(",", "")).first.group(0));
    return number;
  }
  
  String parseTime(String stringWithTime) {
    int amount = parseNumber(stringWithTime);
    return amount.toString() + " " + stringWithTime.split(" ").elementAt(1); 
  }
}