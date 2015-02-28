part of sg2o;

class GiveAway {
  String name;
  String created;
  String creator;
  String remaining;
  String link;
  Element image;
  Element avatar;
  int points;
  int entries;
  int copies = 1;
  int comments;
  int contributorLevel = 0;
  int sgGameId;
  bool isContributorGA;
  bool isGroupGA;
  bool isWishListGA;
  bool isCustomWishListGA;
  bool entered;
  bool isWhiteListed;

  Element giveAwayContainer;
  /// Use this to change border color.
  Element giveAwayLink;

  String borderClass;

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
    this.isWishListGA = wishList.isOnWishList(name);
    this.isCustomWishListGA = customWishList.isOnWishList(name);
    this.entered = gaHtml.querySelectorAll('.$classGAEntered').length > 0;
    this.isWhiteListed = gaHtml.querySelectorAll('.$classGAWhiteListed').length > 0;
    this.sgGameId = parseNumber(gaHtml.querySelector('.$classGAHide').getAttribute('data-game-id'));

    this.borderClass = getBorderColorClass();
  }

  Element wrappedWithStyles() {
    giveAwayContainer = new DivElement();

    Element informationContainer = createInformationContainer();

    giveAwayLink = createElementWithName('a', '');
    Element giveAwayImage = new DivElement();
    giveAwayLink
      ..setAttribute('href', this.link)
      ..classes.add(classGAImageOuterBorder)
      ..classes.add(classGAGameImage)
      ..classes.add(borderClass)
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

    DivElement blackListLinkContainer = new DivElement();
    blackListLinkContainer
      ..classes.add(classFloatLeft)
      ..classes.add(classFontAwesome)
      ..classes.add(classEyeSlash)
      ..classes.add(classOneClickBlackList)
      ..onClick.listen((Event e) {
          addGameToBlackList();
          gridView.hideTemporarily(this.name);
        });

    DivElement customWishListContainer = new DivElement();
    customWishListContainer
      ..classes.add(classFloatLeft)
      ..classes.add(classCustomWishList)
      ..onClick.listen(toggleGameOnCustomWishList);
    if (isCustomWishListGA) {
      customWishListContainer.classes.add(classHighLightCustomWishList);
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
      blackListLinkContainer.classes.add(classFaded);
      customWishListContainer.classes.add(classFaded);
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
      ..append(levelContainer)
      ..append(createStopStyleParagraph())
      ..append(blackListLinkContainer)
      ..append(customWishListContainer);

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
    List borderLevels = [
        '', classBorderGroup, // 0, 1
        classBorderContributorAbove, classBorderGroupContributorAbove, classBorderContributorBelow, classBorderGroupContributorBelow, '', '', // 2-7
        classBorderWishList, classBorderGroupWishList, classBorderContributorAboveWishList, classBorderGroupContributorAboveWishList, // 8-11
        classBorderContributorBelowWishList, classBorderGroupContributorBelowWishList, '', '', // 12-15
        classBorderWhiteList, classBorderWhiteListGroup, classBorderWhiteListContributorAbove, classBorderWhiteListGroupContributorAbove, // 16-19
        classBorderWhiteListContributorBelow, classBorderWhiteListGroupContributorBelow, '', '', // 20-23
        classBorderWhiteListWishList, classBorderWhiteListGroupWishList, classBorderWhiteListWishListContributorAbove, classBorderWhiteListGroupWishListContributorAbove, // 24-27
        classBorderWhiteListWishListContributorBelow, classBorderWhiteListWishListGroupContributorBelow, '', '' // 28-31
    ];

    int borderLevel = 0;
    borderLevel += (isGroupGA) ? 1 : 0;
    borderLevel += (isContributorGA && contributorLevel > myLevel) ? 2 : 0;
    borderLevel += (isContributorGA && contributorLevel <= myLevel) ? 4 : 0;
    borderLevel += (isWishListGA || isCustomWishListGA) ? 8 : 0;
    borderLevel += (isWhiteListed) ? 16 : 0;

    return borderLevels[borderLevel];
  }

  bool isNotBlackListed() {
    return !blackList.isOnBlackList(name);
  }

  bool isBlackListed() {
    return !isNotBlackListed();
  }

  bool isEntered() {
    return this.entered;
  }

  void addGameToBlackList() {
    Map<String, String> formData = new Map();
    formData['xsrf_token'] = querySelectorAll('input[name="xsrf_token"]')[0].getAttribute('value');
    formData['game_id'] = this.sgGameId.toString();
    formData['do'] = 'hide_giveaways_by_game_id';
    HttpRequest.postFormData('/', formData);
  }

  void toggleGameOnCustomWishList(Event e) {
    Element target = e.target;
    giveAwayLink.classes.remove(borderClass);
    if (isCustomWishListGA) {
      isCustomWishListGA = false;
      customWishList.removeGameFromWishList(name);
      target.classes.remove(classHighLightCustomWishList);
    } else {
      isCustomWishListGA = true;
      customWishList.addGameToWishList(name);
      target.classes.add(classHighLightCustomWishList);
    }
    borderClass = getBorderColorClass();
    giveAwayLink.classes.add(borderClass);
    gridView.updateVisibilityAndBorders(name);
  }

  void updateBorder(String name) {
    if (name == this.name) {
      isWishListGA = wishList.isOnWishList(this.name);
      isCustomWishListGA = customWishList.isOnWishList(this.name);

      giveAwayLink.classes.remove(borderClass);
      borderClass = getBorderColorClass();
      giveAwayLink.classes.add(borderClass);
    }
  }

  void hideTemporarily(String name) {
    if (name == this.name) {
      giveAwayContainer.classes.add(classHidden);
    }
  }
}