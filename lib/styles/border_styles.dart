part of sg2o;

/// Class for border styles of the giveaways.
class BorderStyles extends Styles {

    BorderStyles() : super();

    /// Adds all border styles to the DOM.
    void addBorderStyles() {
        String groupColor = settings.getGroupColor();
        String contributorAboveLevelColor = settings.getContributorAboveColor();
        String contributorBelowLevelColor = settings.getContributorBelowColor();
        String wishListColor = settings.getWishListColor();
        String whiteListColor = settings.getWhiteListColor();

        styleSheet.insertRule(createSimpleBorderRule(classBorderGroup, groupColor), 0);
        styleSheet.insertRule(createSimpleBorderRule(classBorderContributorAbove, contributorAboveLevelColor), 0);
        styleSheet.insertRule(createSimpleBorderRule(classBorderContributorBelow, contributorBelowLevelColor), 0);
        styleSheet.insertRule(createSimpleBorderRule(classBorderWishList, wishListColor), 0);
        styleSheet.insertRule(createSimpleBorderRule(classBorderWhiteList, whiteListColor), 0);

        styleSheet.insertRule(createTwoColorStripedBorderRule(classBorderGroupContributorAbove, groupColor, contributorAboveLevelColor), 0);
        styleSheet.insertRule(createTwoColorStripedBorderRule(classBorderGroupContributorBelow, groupColor, contributorBelowLevelColor), 0);
        styleSheet.insertRule(createTwoColorStripedBorderRule(classBorderGroupWishList, groupColor, wishListColor), 0);
        styleSheet.insertRule(createTwoColorStripedBorderRule(classBorderContributorAboveWishList, contributorAboveLevelColor, wishListColor), 0);
        styleSheet.insertRule(createTwoColorStripedBorderRule(classBorderContributorBelowWishList, contributorBelowLevelColor, wishListColor), 0);
        styleSheet.insertRule(createTwoColorStripedBorderRule(classBorderWhiteListGroup, whiteListColor, groupColor), 0);
        styleSheet.insertRule(createTwoColorStripedBorderRule(classBorderWhiteListContributorAbove, whiteListColor, contributorAboveLevelColor), 0);
        styleSheet.insertRule(createTwoColorStripedBorderRule(classBorderWhiteListContributorBelow, whiteListColor, contributorBelowLevelColor), 0);
        styleSheet.insertRule(createTwoColorStripedBorderRule(classBorderWhiteListWishList, whiteListColor, wishListColor), 0);

        styleSheet.insertRule(createThreeColorStripedBorderRule(classBorderGroupContributorAboveWishList, groupColor, contributorAboveLevelColor, wishListColor), 0);
        styleSheet.insertRule(createThreeColorStripedBorderRule(classBorderGroupContributorBelowWishList, groupColor, contributorBelowLevelColor, wishListColor), 0);
        styleSheet.insertRule(createThreeColorStripedBorderRule(classBorderWhiteListGroupContributorAbove, whiteListColor, groupColor, contributorAboveLevelColor), 0);
        styleSheet.insertRule(createThreeColorStripedBorderRule(classBorderWhiteListGroupContributorBelow, whiteListColor, groupColor, contributorBelowLevelColor), 0);
        styleSheet.insertRule(createThreeColorStripedBorderRule(classBorderWhiteListGroupWishList, whiteListColor, groupColor, wishListColor), 0);
        styleSheet.insertRule(createThreeColorStripedBorderRule(classBorderWhiteListWishListContributorAbove, whiteListColor, wishListColor, contributorAboveLevelColor), 0);
        styleSheet.insertRule(createThreeColorStripedBorderRule(classBorderWhiteListWishListContributorBelow, whiteListColor, wishListColor, contributorBelowLevelColor), 0);

        styleSheet.insertRule(createFourColorStripedBorderRule(classBorderWhiteListGroupWishListContributorAbove, whiteListColor, groupColor, wishListColor, contributorAboveLevelColor), 0);
        styleSheet.insertRule(createFourColorStripedBorderRule(classBorderWhiteListWishListGroupContributorBelow, whiteListColor, groupColor, wishListColor, contributorBelowLevelColor), 0);
    }

    /// Returns a simple rule for borders with one color.
    String createSimpleBorderRule(String className, String color) {
        String rule =
        '''
.$className {
  background: $color;
}
''';
        return rule;
    }

    /// Returns a rule for borders with two colors.
    String createTwoColorStripedBorderRule(String className, String color1, String color2) {
        String rule =
        '''
.$className {
  background-color: $color1;
  background-image: linear-gradient(
    to right,
    transparent 50%,
    $color2 50%
  );
  background-size: 90px 90px;
}
''';
        return rule;
    }

    /// Returns a rule for borders with three colors.
    String createThreeColorStripedBorderRule(String className, String color1, String color2, String color3) {
        String rule =
        '''
.$className {
  background-image:
    linear-gradient(
      to right,
      $color1 33.33%,
      $color2 33.33%,
      $color2 66.66%,
      $color3 66.66%
    );
  background-size: 90px 90px;
}
''';
        return rule;
    }

    /// Returns a rule for borders with four colors.
    String createFourColorStripedBorderRule(String className, String color1, String color2, String color3, String color4) {
        String rule =
        '''
.$className {
  background-image:
    linear-gradient(
      to right,
      $color1 25%,
      $color2 25%,
      $color2 50%,
      $color3 50%,
      $color3 75%,
      $color4 75%
    );
  background-size: 90px 90px;
}
''';
        return rule;
    }
}