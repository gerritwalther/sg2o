part of sg2o;

/// Class for one giveaway. Parses the whole information from the DOM. Also creates a collapsed element with the information.
class GiveAway {
    late String name;
    late String created;
    late String creator;
    late String remaining;
    late String link;
    late String profileLink;
    late String giveAwayId;
    late String imageStyle;
    late String avatar;
    late int points;
    late int entries;
    int copies = 1;
    late int comments;
    int contributorLevel = 0;
    late int sgGameId;
    late int steamId;
    late String steamLink;
    late num chanceOfWin;
    late bool isContributorGA;
    late bool isGroupGA;
    late bool isWishListGA;
    late bool isCustomWishListGA;
    late bool entered;
    late bool isWhiteListed;
    bool isBlackListed = false;
    bool isSGPBlacklisted = false;
    bool isImageAvailable = false;

    /// Container for this game. Used for hiding it after moving it to the blacklist.
    Element? giveAwayContainer;

    /// Use this to change border color.
    late Element giveAwayLink;

    /// Current border class which is updated when adding to the custom wishlist.
    late String borderClass;


    /// Constructor that parses the giveaway from [gaHtml]. The passed html has to contain a number of different elements.
    GiveAway(Element gaHtml) {
        ElementList copiesAndPoints = gaHtml.querySelectorAll('span.$classGAHeadingThin');
        Element copies;
        Element points;
        if (copiesAndPoints.length == 1) {
            points = copiesAndPoints[0];
        } else {
            copies = copiesAndPoints[0];
            points = copiesAndPoints[1];
            this.copies = parseNumber(copies.text)!;
        }
        this.points = parseNumber(points.text)!;
        Element? nameAndLink = gaHtml.querySelector('a.$classGAName');
        this.name = nameAndLink!.text!;
        this.link = nameAndLink.getAttribute('href')!;
        this.giveAwayId = parseIdFromLink(this.link);
        this.remaining = parseTime(gaHtml.querySelector('div.$classGAColumns>div>span')!.text!);
        this.created = parseTime(gaHtml.querySelector('div.$classGAColumnWidthFill')!.text!);
        this.creator = gaHtml.querySelector('.$classGAUserName')!.text!;
        ElementList entriesAndComments = gaHtml.querySelectorAll('div.$classGALinks>a>span');
        this.entries = parseNumber(entriesAndComments.first.text)!;
        this.comments = parseNumber(entriesAndComments.last.text)!;
        this.isImageAvailable = gaHtml.querySelector('a.$classGAGameImageMissing') == null;
        if (this.isImageAvailable) {
            this.imageStyle = gaHtml.querySelector('a.$classGAGameImage')!.style.cssText!;
        }
        this.avatar = gaHtml.querySelector('.$classGAAvatar')!.style.backgroundImage;
        this.profileLink = gaHtml.querySelector('.$classGAAvatar')!.getAttribute('href')!;
        ElementList contributorElement = gaHtml.querySelectorAll('.$classGAContributorLvl');
        this.isContributorGA = contributorElement.length > 0;
        if (this.isContributorGA) {
            this.contributorLevel = parseNumber(contributorElement[0].text)!;
        }
        this.isGroupGA = gaHtml.querySelectorAll('.$classGAGroupIcon').length > 0;
        this.isWishListGA = wishList.isOnWishList(name);
        this.isCustomWishListGA = customWishList.isOnWishList(name);
        this.entered = gaHtml.querySelectorAll('.$classGAEntered').length > 0;
        this.isWhiteListed = gaHtml.querySelectorAll('.$classGAWhiteListed').length > 0;
        this.sgGameId = parseNumber(gaHtml.getAttribute('data-game-id'))!;
        this.steamLink = getSteamLink(gaHtml);
        this.steamId = parseNumber(this.steamLink)!;

        this.chanceOfWin = ((100 * this.copies) / (this.entries + ((entered) ? 0 : 1))).clamp(0, 100);

        this.borderClass = getBorderColorClass();
    }

    String getSteamLink(Element gaHtml) {
        Element? querySelector = gaHtml.querySelector('a.$classGAIcon');
        if (querySelector == null) {
            return '';
        }
        return querySelector.getAttribute('href')!;
    }

    /// Return this giveaway as small gridview compatible [Element].
    Element? wrappedWithStyles() {
        giveAwayContainer = new DivElement();

        Element informationContainer = createInformationContainer();

        giveAwayLink = createElementWithName('a', '');
        Element giveAwayImage = new DivElement();
        giveAwayLink
            ..setAttribute('href', this.link)
            ..setAttribute('target', '_blank')
            ..classes.add(classGAImageOuterBorder)
            ..classes.add(classGAGameImage)
            ..classes.add(borderClass)
            ..append(giveAwayImage);

        if (this.isImageAvailable) {
            giveAwayImage
                ..setAttribute('style', this.imageStyle)
                ..classes.add(classGAGameImage)
            ;
        } else {
            giveAwayImage
                ..append(FAElement().create('fa-picture-o'))
                ..classes.add(classGAGameImageMissing)
            ;
        }

        if (isSGPBlacklisted) {
            Element faBan = FAElement().create('fa-ban');
            giveAwayImage.append(faBan);
            giveAwayImage.classes.add(classGAisSGPBlacklisted);
        }

        Element giveAwayLinkContainer = new DivElement();
        giveAwayLinkContainer
            ..append(giveAwayLink)
        ;

        giveAwayContainer
            ?..classes.add(classGridView)
            ..append(giveAwayLinkContainer)
            ..append(informationContainer)
            ..onMouseEnter.listen((e) => informationContainer.classes.remove(classHidden))
            ..onMouseLeave.listen((e) => informationContainer.classes.add(classHidden));

        if (entered) {
            giveAwayLinkContainer.classes.add(classFaded);
        }

        return giveAwayContainer;
    }

    /// Creates the information container [Element].
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
            ..append(createStrongElement(this.copies.toString()))
            ..append(createTextElement((this.copies == 1) ? ' Copy' : ' Copies'));

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

        DivElement avatarContainer = new DivElement()
            ..classes.add(classFloatRight)
            ..classes.add(classGridViewAvatar)
            ..id = 'sg2o-$creator-$giveAwayId-avatar'
            ..attributes.putIfAbsent('style', () => 'background-image: ${this.avatar};')
            ..onClick.listen((Event e) {
                window.open(this.profileLink, '_blank');
            })
        ;
        // Add the tooltip when the mouse hovers the giveAwayContainer, otherwise it will not be added
        ProfileTooltip? profileTooltip = null;
        giveAwayContainer
            ?..onMouseEnter.listen((Event e) {
                if (profileTooltip == null) {
                    profileTooltip = new ProfileTooltip('sg2o-$creator-$giveAwayId-avatar', creator, avatarContainer);
                }
            });
        // Only load the profile info when hovering over the avatar to reduce load on SG
        avatarContainer
            ..onMouseEnter.listen((Event e) {
                profileTooltip?.addUserContent();
            })
        ;

        DivElement entriesContainer = new DivElement();
        entriesContainer
            ..classes.add(classFloatLeft)
            ..append(createStrongElement(this.entries.toString()))
            ..append(createTextElement(' entries'));

        // Chance is calculated by entries. Only add 1 entry, when not yet entered.
        DivElement chanceToWinContainer = new DivElement()
            ..classes.add(classFloatRight)
            ..append(createStrongElement(this.chanceOfWin.toStringAsFixed(2)))
            ..append(createTextElement(' %'));

        DivElement commentsContainer = new DivElement();
        commentsContainer
            ..classes.add(classFloatLeft)
            ..append(createStrongElement(this.comments.toString()))
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

        // Add [DivElement] to add game directly to blackList.
        DivElement blackListLinkContainer = new DivElement()
            ..classes.add(classFloatLeft)
            ..classes.add(classFontAwesome)
            ..classes.add(classEyeSlash)
            ..classes.add(classOneClickBlackList)
            ..id = 'sg2o-$creator-$giveAwayId-blacklist'
            ..onClick.listen((Event e) {
                addGameToBlackList();
                gridView.removeByName(this.name);
            })
        ;
        new SimpleTooltip('sg2o-$creator-$giveAwayId-blacklist', 'Add "${this.name}" to the blacklist.', blackListLinkContainer);

        // Add [DivElement] to add game directly to custom wishlist.
        DivElement customWishListContainer = new DivElement()
            ..classes.add(classFloatLeft)
            ..classes.add(classFontAwesome)
            ..classes.add(classCustomWishList)
            ..id = 'sg2o-$creator-$giveAwayId-custom-wishlist'
            ..onClick.listen(toggleGameOnCustomWishList)
        ;
        new SimpleTooltip('sg2o-$creator-$giveAwayId-custom-wishlist', 'Add "${this.name}" to a custom wishlist', customWishListContainer);

        // Add [DivElement] to add giveaway directly to the [GiveAwayBlackList].
        DivElement giveAwayBlackListContainer = new DivElement()
            ..classes.add(classFloatLeft)
            ..classes.add(classFontAwesome)
            ..classes.add(classFrown)
            ..classes.add(classGiveAwayBlackList)
            ..id = 'sg2o-$creator-$giveAwayId-id-blacklist'
            ..onClick.listen((Event e) {
                giveAwayBlackList.addGameToBlackList(this.giveAwayId);
                // remove giveaway from gridview so it is not added back again
                gridView.remove(this);
                // remove the container from the dom
                giveAwayContainer?.remove();
            })
        ;
        new SimpleTooltip('sg2o-$creator-$giveAwayId-id-blacklist', 'Hide this giveaway with ID "${this.giveAwayId}" until it is finished.', giveAwayBlackListContainer);

        // Add [DivElement] to open the Steam store page.
        DivElement steamLinkContainer = new DivElement()
            ..classes.add(classFloatLeft)
            ..classes.add(classFontAwesome)
            ..classes.add(classSteamLink)
            ..classes.add(classFASteam)
            ..id = 'sg2o-$creator-$giveAwayId-steam'
            ..onClick.listen((Event e) {
                window.open(this.steamLink, '_blank');
            })
        ;
        new SimpleTooltip('sg2o-$creator-$giveAwayId-steam', 'Open Steam page for this game.', steamLinkContainer);

        if (isCustomWishListGA) {
            customWishListContainer.classes.add(classFAFullHeart);
        } else {
            customWishListContainer.classes.add(classFAEmptyHeart);
        }

        // Add a lowered opacity if game is entered.
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
            giveAwayBlackListContainer.classes.add(classFaded);
            steamLinkContainer.classes.add(classFaded);
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
            ..append(customWishListContainer)
            ..append(giveAwayBlackListContainer)
            ..append(steamLinkContainer)
        ;

        return informationContainer;
    }

    /// Removes this container from all containers and marks it as blacklisted when matching [name].
    void removeGiveAwayContainer(String name) {
        if (this.name == name) {
            window.console.info('Adding ${name} to blacklist.');
            giveAwayContainer?.remove();
            this.isBlackListed = true;
        }
    }

    /// Returns a [String]-representation of this giveaway.
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

    /// Returns the correct border class for this giveaway.
    String getBorderColorClass() {
        List borderLevels = [
            classBorderNone, classBorderGroup, // 0, 1
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

    /// Returns [true] if game is NOT on the SG+ blacklist.
    bool isNotSGPBlackListed() {
        return !sgpBlackList.isOnBlackList(name);
    }

    /// Returns [true] if game IS on the SG+ blacklist.
    bool isSGPBlackListed() {
        return !isNotSGPBlackListed();
    }

    /// Returns [true] if giveaway id is blacklisted.
    bool isGiveAwayIdBlackListed() {
        return giveAwayBlackList.isOnBlackList(this.giveAwayId);
    }

    /// Returns [true] if giveaway is entered.
    bool isEntered() {
        return this.entered;
    }

    /// Sends a post request to directly add the game on SGs blacklist.
    void addGameToBlackList() {
        Map<String, String> formData = new Map();
        String? xsrfToken = querySelectorAll('input[name="xsrf_token"]')[0].getAttribute('value');
        formData['xsrf_token'] = xsrfToken!;
        formData['game_id'] = this.sgGameId.toString();
        formData['do'] = 'hide_giveaways_by_game_id';
        HttpRequest.postFormData('/ajax.php', formData);
    }

    /// Adds/removes this game to the custom sg2o wishlist.
    void toggleGameOnCustomWishList(Event e) {
        Element? target = e.target as Element?;
        giveAwayLink.classes.remove(borderClass);
        if (isCustomWishListGA) {
            isCustomWishListGA = false;
            customWishList.removeGameFromWishList(name);
            target?.classes.remove(classFAFullHeart);
            target?.classes.add(classFAEmptyHeart);
        } else {
            isCustomWishListGA = true;
            customWishList.addGameToWishList(name);
            target?.classes.remove(classFAEmptyHeart);
            target?.classes.add(classFAFullHeart);
        }
        borderClass = getBorderColorClass();
        giveAwayLink.classes.add(borderClass);
        gridView.updateVisibilityAndBorders(name);
    }

    /// Updates the border color. This will be called by the gridview when custom wishlisting a game.
    void updateBorder(String name) {
        if (name == this.name) {
            isWishListGA = wishList.isOnWishList(this.name);
            isCustomWishListGA = customWishList.isOnWishList(this.name);

            giveAwayLink.classes.remove(borderClass);
            borderClass = getBorderColorClass();
            giveAwayLink.classes.add(borderClass);
        }
    }

    /// Toggles visibility of this game when [hide] is [true].
    void hideTemporarily(bool hide) {
        if (!this.isBlackListed && !(this.entered && settings!.hideEnteredGames()) && giveAwayContainer != null) {
            if (hide) {
                giveAwayContainer?.classes.add(classHidden);
            } else {
                giveAwayContainer?.classes.remove(classHidden);
            }
        }
    }

    /// Returns [true] if [this.contributorLevel] is in range of [levelFrom] and [levelTo].
    bool isInContributorRange(num levelFrom, num levelTo) {
        return levelFrom <= this.contributorLevel && this.contributorLevel <= levelTo;
    }

    /// Returns [true] if [this.points] is in range of [pointsFrom] and [pointsTo].
    bool isInPointsRange(num pointsFrom, num pointsTo) {
        return pointsFrom <= this.points && this.points <= pointsTo;
    }

    /// Returns [true] if [this.chanceOfWin] is in range of [chanceFrom] and [chanceTo].
    bool isInChanceRange(num chanceFrom, num chanceTo) {
        return chanceFrom <= this.chanceOfWin && this.chanceOfWin <= chanceTo;
    }

    void setSGPBlacklisted(bool sgpBlacklisted) {
        this.isSGPBlacklisted = sgpBlacklisted;
    }
}