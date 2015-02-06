part of SGv2plus;

class GiveAway {
  String name;
  String created;
  String creator;
  String remaining;
  Element image;
  Element avatar;
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
    this.image = gaHtml.querySelector('a.global__image-outer-wrap--game-medium').children.first;
    this.avatar = gaHtml.querySelector('.global__image-outer-wrap--avatar-small>.global__image-inner-wrap');
  }

  Element wrappedWithStyles() {
    Element giveAwayContainer = new DivElement();

    Element informationContainer = createInformationContainer();

    Element giveAwayLink = createElementWithName('a', '');
    Element giveAwayImage = new DivElement();
    giveAwayLink
      ..setAttribute('href', this.link)
      ..classes.add('global__image-outer-wrap')
      ..classes.add('global__image-outer-wrap--game-medium')
      ..append(giveAwayImage);

    giveAwayImage
      ..classes.add('global__image-inner-wrap')
      ..setAttribute('style', this.image.getAttribute('style'));

    giveAwayContainer
      ..classes.add('giveaway-gridview')
      ..append(giveAwayLink)
      ..append(informationContainer);

    giveAwayContainer
      ..onMouseEnter.listen((e) => informationContainer.classes.remove('hidden'))
      ..onMouseLeave.listen((e) => informationContainer.classes.add('hidden'));

    return giveAwayContainer;
  }

  Element createInformationContainer() {
    DivElement informationContainer = new DivElement();

    informationContainer
      ..classes.add('hidden')
      ..classes.add('gridview-info')
      ..setAttribute('style', 'border-top: 1px #FFFFFF;');

    DivElement nameContainer = new DivElement();
    nameContainer
      ..classes.add('ga-name')
      ..innerHtml = name;


    DivElement copiesContainer = new DivElement();
    copiesContainer
      ..classes.add('float-left')
      ..append(createStrongElement(this.copies))
      ..append(createTextElement((this.copies == 1) ? ' Copy': ' Copies'));

    DivElement pointsContainer = new DivElement();
    pointsContainer
      ..classes.add('float-right')
      ..append(createStrongElement(this.points.toString() + 'P'));

    DivElement timeRemainingContainer = new DivElement();
    timeRemainingContainer
      ..classes.add('float-left')
      ..setAttribute('style', 'margin-top: -16px;')
      ..append(createStrongElement(this.remaining))
      ..append(createTextElement(' remaining'));

    DivElement avatarContainer = new DivElement();
    avatarContainer
      ..classes.add('float-right')
      ..classes.add('gridview-avatar')
      ..append(this.avatar);

    DivElement entriesContainer = new DivElement();
    entriesContainer
      ..classes.add('float-left')
      ..append(createStrongElement(this.entries))
      ..append(createTextElement(' entries'));

    DivElement chanceToWinContainer = new DivElement();
    chanceToWinContainer
      ..classes.add('float-right')
      ..append(createStrongElement((100 / (this.entries + 1)).toStringAsFixed(2)))
      ..append(createTextElement(' %'));

    DivElement commentsContainer = new DivElement();
    commentsContainer
      ..classes.add('float-left')
      ..append(createStrongElement(this.comments))
      ..append(createTextElement(' comments'));

    informationContainer
      ..append(nameContainer)
      ..append(avatarContainer)
      ..append(copiesContainer)
      ..append(pointsContainer)
      ..append(createStopStyleParagraph())
      ..append(timeRemainingContainer)
      ..append(createStopStyleParagraph())
      ..append(entriesContainer)
      ..append(chanceToWinContainer)
      ..append(createStopStyleParagraph())
      ..append(commentsContainer);

    return informationContainer;
  }

  void print() {
    window.console.info(toString());
  }

  String toString() {
    return "Giveaway: " + name + " with " + points.toString() + " Points, created by " + creator + " " + created + " ago,  still open for: " + remaining + ", has " + entries.toString() + " entries and " + comments.toString() + " comments, link: " + link;
  }
}