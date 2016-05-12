part of sg2o;

/// Class for the layer to show the recently blacklisted games.
class LayerRecentlyBlacklisted extends Layer {

    LayerRecentlyBlacklisted() : super();

    @override
    Element createLayer(String layerId) {
        // Fullscreen overlay
        DivElement overlayContainer = new DivElement();
        overlayContainer
            ..id = layerId
            ..classes.add(classModalDialog)
        ;

        DivElement overlayInnerContainer = createLayerContainer();

        Element closeLink = createCloseLink();


        overlayInnerContainer
            ..append(closeLink)
        ;

        overlayContainer.append(overlayInnerContainer);
        return overlayContainer;
    }

    @override
    DivElement createLayerContainer() {
        DivElement innerContainer = new DivElement();

        DivElement heading = this.createHeading('Recently blacklisted games');

        DivElement table = new DivElement();
        table.classes.add('table');

        DivElement tableHeading = createTableHeading();

        innerContainer
            ..append(heading)
        ;

        table.append(tableHeading);

        appendRecentlyBlacklistedGames(table);

        innerContainer.append(table);

        return innerContainer;
    }

    void appendRecentlyBlacklistedGames(DivElement innerContainer) {
        DivElement tableRows = new DivElement();
        tableRows.classes.add(classTableRows);
        tableRows.setAttribute('style', 'max-height: 500px; overflow: auto;');

        List<BlackListedGame> blacklistedGiveaways = gameBlackListHistory.getAll();

        blacklistedGiveaways.sort((BlackListedGame a, BlackListedGame b) => b.added.compareTo(a.added));

        blacklistedGiveaways.forEach((BlackListedGame blg) {
            tableRows.append(createTableRow(blg));
        });

        innerContainer.append(tableRows);
    }

    DivElement createTableRow(BlackListedGame blg) {
        DivElement tableRowOuter = new DivElement();
        tableRowOuter.classes.add(classTableRowOuterWrap);
        tableRowOuter.setAttribute('id', idBlacklistHistoryRow + StringUtil.gameNameToIdCompatibleString(blg.name));

        DivElement tableRowInner = new DivElement();
        tableRowInner.classes.add(classTableRowInnerWrap);

        tableRowOuter.append(tableRowInner);

        tableRowInner
            ..append(createImageContainer(blg))
            ..append(createNameContainer(blg))
            ..append(createDateColumn(blg))
            ..append(createRemoveColumn(blg))
        ;
        return tableRowOuter;
    }

    Node createRemoveColumn(BlackListedGame blackListedGame) {
        DivElement removeLinkContainer = new DivElement();
        removeLinkContainer.classes
            ..add(classTableColumnWidthSmall)
            ..add(classTextCenter)
        ;

        DivElement removeLink = new DivElement();
        removeLink.classes
            ..add(classTableRemoveDefault)
            ..add(classIsClickable)
        ;

        FAElement iconElement = new FAElement();
        iconElement.classes
            ..add('icon-red')
            ..add('fa-times-circle')
        ;
        iconElement.setAttribute('style', 'padding-right:5px;');

        SpanElement linkElement = new SpanElement();
        linkElement.classes.add(classTableColumnSecondaryLink);
        linkElement.innerHtml = 'Remove';

        removeLink
            ..append(iconElement)
            ..append(linkElement)
        ;

        removeLink.onClick.listen((e) {
            gameBlackListHistory.removeFromBlackList(blackListedGame.name, blackListedGame.sgGameId);
            // remove entry from the html
            body.querySelector('#${idBlacklistHistoryRow + StringUtil.gameNameToIdCompatibleString(blackListedGame.name)}').remove();
        });

        removeLinkContainer.append(removeLink);

        return removeLinkContainer;
    }

    Node createDateColumn(BlackListedGame blackListedGame) {
        DivElement textContainer = new DivElement();
        textContainer.classes
            ..add(classTableColumnWidthSmall)
            ..add(classTextCenter)
        ;

        SpanElement time = new SpanElement();
        time.setAttribute('title', blackListedGame.added.toIso8601String());
        time.innerHtml = new TimeUtil().timeSince(blackListedGame.added);

        textContainer.append(time);

        return textContainer;
    }

    Node createImageContainer(BlackListedGame blackListedGame) {
        DivElement imageContainer = new DivElement();

        DivElement imageLink = new DivElement();
        imageLink.classes
            ..add(classGAImageOuterBorder)
            ..add(classGAImageOuterBorderGameSmall)
        ;

        DivElement image = new DivElement();
        image.classes.add(classGAImageInnerWrap);
        image.setAttribute('style',
            'background-image:url(https://steamcdn-a.akamaihd.net/steam/apps/${blackListedGame.steamId}/capsule_184x69.jpg);');

        imageLink.append(image);

        imageContainer.append(imageLink);

        return imageContainer;
    }


    Node createNameContainer(BlackListedGame blackListedGame) {
        DivElement nameContainer = new DivElement();
        nameContainer.classes.add(classTableColumnWidthFill);

        ParagraphElement nameElement = new ParagraphElement();
        nameElement.classes.add(classTableColumnHeading);
        nameElement.innerHtml = blackListedGame.name;

        ParagraphElement linkContainer = new ParagraphElement();

        String link = 'http://store.steampowered.com/app/${blackListedGame.steamId}';
        Element linkElement = new Element.a();
        linkElement.classes.add(classTableColumnSecondaryLink);
        linkElement.setAttribute('href', link);
        linkElement.setAttribute('rel', 'nofollow');
        linkElement.setAttribute('target', '_blank');
        linkElement.innerHtml = link;

        linkContainer.append(linkElement);

        nameContainer
            ..append(nameElement)
            ..append(linkContainer)
        ;

        return nameContainer;
    }

    DivElement createTableHeading() {
        DivElement tableHeading = new DivElement();
        tableHeading.classes.add(classTableHeading);

        tableHeading.append(
            new DivElement()
                ..classes.add(classTableColumnWidthFill)
                ..innerHtml = 'Game name'
        );
        tableHeading.append(
            new DivElement()
                ..classes.add(classTableColumnWidthSmall)
                ..classes.add(classTextCenter)
                ..innerHtml = 'Date Added'
        );
        tableHeading.append(
            new DivElement()
                ..classes.add(classTableColumnWidthSmall)
                ..classes.add(classTextCenter)
                ..innerHtml = 'Remove from blacklist'
        );

        return tableHeading;
    }

    @override
    void instantiateLayer() {
        body.append(createLayer(classSG2ORecentlyBlackListedLink));
    }
}

