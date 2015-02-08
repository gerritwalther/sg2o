part of sg2o;

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
  bool isContributorGA;
  int contributorLevel = 0;
  bool isGroupGA;
  bool isWishListGA;
  bool entered;

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
    ElementList contributorElement = gaHtml.querySelectorAll('.giveaway__column--contributor-level');
    this.isContributorGA = contributorElement.length > 0;
    if (this.isContributorGA) {
      this.contributorLevel = parseNumber(contributorElement[0].text);
    }
    this.isGroupGA = gaHtml.querySelectorAll('.giveaway__column--group').length > 0;
    this.isWishListGA = false;
    this.entered = gaHtml.querySelectorAll('.is-faded').length > 0;
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
      ..classes.add(getBorderColorClass())
      ..append(giveAwayImage);

    giveAwayImage
      ..classes.add('global__image-inner-wrap')
      ..setAttribute('style', this.image.getAttribute('style'));

    giveAwayContainer
      ..classes.add('giveaway-gridview')
      ..append(giveAwayLink)
      ..append(informationContainer)
      ..onMouseEnter.listen((e) => informationContainer.classes.remove('hidden'))
      ..onMouseLeave.listen((e) => informationContainer.classes.add('hidden'));

    if (entered) {
      giveAwayLink.classes.add('faded');
    }

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

    DivElement levelContainer = new DivElement();
    levelContainer
      ..classes.add('giveaway__column--contributor-level')
      ..classes.add('float-right')
      ..innerHtml = '$contributorLevel+';

    if (myLevel >= contributorLevel) {
      levelContainer.classes.add('giveaway__column--contributor-level--positive');
    } else {
      levelContainer.classes.add('giveaway__column--contributor-level--negative');
    }

    if (entered) {
      nameContainer.classes.add('faded');
      copiesContainer.classes.add('faded');
      pointsContainer.classes.add('faded');
      timeRemainingContainer.classes.add('faded');
      avatarContainer.classes.add('faded');
      entriesContainer.classes.add('faded');
      chanceToWinContainer.classes.add('faded');
      commentsContainer.classes.add('faded');
      levelContainer.classes.add('faded');
    }

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
      ..append(commentsContainer)
      ..append(levelContainer);

    return informationContainer;
  }

  void print() {
    window.console.info(toString());
  }

  String toString() {
    return "Giveaway: " + name
        + " with " + points.toString() + " Points, created by " + creator
        + " " + created + " ago,  still open for: " + remaining
        + ", has " + entries.toString() + " entries and "
        + comments.toString() + " comments, link: " + link
        + " is a group GA: " + isGroupGA.toString()
        + " and a contributorGA: " + isContributorGA.toString()
        + " with level " + contributorLevel.toString();
  }

  String getBorderColorClass() {
    List borderLevels = ['', 'group', // 0, 1
                         'contributor-above', 'group-contributor-above', 'contributor-below', 'group-contributor-below', '', '', // 2-7
                         'wishlist', 'group-wishlist', 'contributor-above-wishlist', 'group-contributor-above-wishlist', // 8-11
                         'contributor-below-wishlist', 'group-contributor-below-wishlist', '', '']; // 12-15
    int borderLevel = 0;
    borderLevel += (isGroupGA) ? 1 : 0;
    borderLevel += (isContributorGA && contributorLevel > myLevel) ? 2 : 0;
    borderLevel += (isContributorGA && contributorLevel <= myLevel) ? 4 : 0;
    borderLevel += (isWishListGA) ? 8 : 0;

    return borderLevels[borderLevel] + '-border';
  }
}