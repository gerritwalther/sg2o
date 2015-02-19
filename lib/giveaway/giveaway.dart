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
    ElementList copiesAndPoints = gaHtml.querySelectorAll('span.$classGAHeadingThin');
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
    Element nameAndLink = gaHtml.querySelector('a.$classGAName');
    this.name = nameAndLink.text;
    this.link = nameAndLink.getAttribute('href');
    this.remaining = parseTime(gaHtml.querySelector('div.$classGAColumns>div>span').text);
    this.created = parseTime(gaHtml.querySelector('div.$classGAColumnWidthFill').text);
    this.creator = gaHtml.querySelector('.$classGAUserName').text;
    ElementList entriesAndComments = gaHtml.querySelectorAll('div.$classGALinks>a>span');
    this.entries = parseNumber(entriesAndComments.first.text);
    this.comments = parseNumber(entriesAndComments.last.text);
    this.image = gaHtml.querySelector('a.$classGAGameImage').children.first;
    this.avatar = gaHtml.querySelector('.$classGAAvatar>.$classGAAvatarImage');
    ElementList contributorElement = gaHtml.querySelectorAll('.$classGAContributorLvl');
    this.isContributorGA = contributorElement.length > 0;
    if (this.isContributorGA) {
      this.contributorLevel = parseNumber(contributorElement[0].text);
    }
    this.isGroupGA = gaHtml.querySelectorAll('.$classGAGroupIcon').length > 0;
    this.isWishListGA = false;
    this.entered = gaHtml.querySelectorAll('.$classGAEntered').length > 0;
  }

  Element wrappedWithStyles() {
    Element giveAwayContainer = new DivElement();

    Element informationContainer = createInformationContainer();

    Element giveAwayLink = createElementWithName('a', '');
    Element giveAwayImage = new DivElement();
    giveAwayLink
      ..setAttribute('href', this.link)
      ..classes.add(classGAImageOuterBorder)
      ..classes.add(classGAGameImage)
      ..classes.add(getBorderColorClass())
      ..append(giveAwayImage);

    giveAwayImage
      ..classes.add(classGAAvatarImage)
      ..setAttribute('style', this.image.getAttribute('style'));

    giveAwayContainer
      ..classes.add(classGridView)
      ..append(giveAwayLink)
      ..append(informationContainer)
      ..onMouseEnter.listen((e) => informationContainer.classes.remove(classHidden))
      ..onMouseLeave.listen((e) => informationContainer.classes.add(classHidden));

    if (entered) {
      giveAwayLink.classes.add(classFaded);
    }

    return giveAwayContainer;
  }

  Element createInformationContainer() {
    DivElement informationContainer = new DivElement();

    informationContainer
      ..classes.add(classHidden)
      ..classes.add(classGridViewInfoContainer)
      ..setAttribute('style', 'border-top: 1px #FFFFFF;');

    DivElement nameContainer = new DivElement();
    nameContainer
      ..classes.add(classGridViewGAName)
      ..innerHtml = name;

    DivElement copiesContainer = new DivElement();
    copiesContainer
      ..classes.add(classFloatLeft)
      ..append(createStrongElement(this.copies))
      ..append(createTextElement((this.copies == 1) ? ' Copy': ' Copies'));

    DivElement pointsContainer = new DivElement();
    pointsContainer
      ..classes.add(classFloatRight)
      ..append(createStrongElement(this.points.toString() + 'P'));

    DivElement timeRemainingContainer = new DivElement();
    timeRemainingContainer
      ..classes.add(classFloatLeft)
      ..setAttribute('style', 'margin-top: -16px;')
      ..append(createStrongElement(this.remaining))
      ..append(createTextElement(' remaining'));

    DivElement avatarContainer = new DivElement();
    avatarContainer
      ..classes.add(classFloatRight)
      ..classes.add(classGridViewAvatar)
      ..append(this.avatar);

    DivElement entriesContainer = new DivElement();
    entriesContainer
      ..classes.add(classFloatLeft)
      ..append(createStrongElement(this.entries))
      ..append(createTextElement(' entries'));

    DivElement chanceToWinContainer = new DivElement();
    chanceToWinContainer
      ..classes.add(classFloatRight)
      ..append(createStrongElement((100 / (this.entries + 1)).toStringAsFixed(2)))
      ..append(createTextElement(' %'));

    DivElement commentsContainer = new DivElement();
    commentsContainer
      ..classes.add(classFloatLeft)
      ..append(createStrongElement(this.comments))
      ..append(createTextElement(' comments'));

    DivElement levelContainer = new DivElement();
    levelContainer
      ..classes.add(classGAContributorLvl)
      ..classes.add(classFloatRight)
      ..innerHtml = '$contributorLevel+';

    if (myLevel >= contributorLevel) {
      levelContainer.classes.add(classGAContributorPos);
    } else {
      levelContainer.classes.add(classGAContributorNeg);
    }

    if (entered) {
      nameContainer.classes.add(classFaded);
      copiesContainer.classes.add(classFaded);
      pointsContainer.classes.add(classFaded);
      timeRemainingContainer.classes.add(classFaded);
      avatarContainer.classes.add(classFaded);
      entriesContainer.classes.add(classFaded);
      chanceToWinContainer.classes.add(classFaded);
      commentsContainer.classes.add(classFaded);
      levelContainer.classes.add(classFaded);
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
    List borderLevels = ['', classBorderGroup, // 0, 1
                         classBorderContributorAbove, classBorderGroupContributorAbove, classBorderContributorBelow, classBorderGroupContributorBelow, '', '', // 2-7
                         classBorderWishList, classBorderGroupWishList, classBorderContributorAboveWishList, classBorderGroupContributorAboveWishList, // 8-11
                         classBorderContributorBelowWishList, classBorderGroupContributorBelowWishList, '', '']; // 12-15
    int borderLevel = 0;
    borderLevel += (isGroupGA) ? 1 : 0;
    borderLevel += (isContributorGA && contributorLevel > myLevel) ? 2 : 0;
    borderLevel += (isContributorGA && contributorLevel <= myLevel) ? 4 : 0;
    borderLevel += (isWishListGA) ? 8 : 0;

    return borderLevels[borderLevel];
  }

  bool isNotBlackListed() {
    return !blackList.isOnBlackList(name);
  }

  bool isEntered() {
    return this.entered;
  }
}