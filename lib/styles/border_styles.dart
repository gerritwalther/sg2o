part of sg2o;

class BorderStyles extends Styles {

  BorderStyles() : super();

  void addBorderStyles() {
    styleSheet.insertRule(createSimpleBorderRule(classBorderGroup, groupColor), 0);
    styleSheet.insertRule(createSimpleBorderRule(classBorderContributorAbove, contributorAboveLevelColor), 0);
    styleSheet.insertRule(createSimpleBorderRule(classBorderContributorBelow, contributorBelowLevelColor), 0);
    styleSheet.insertRule(createSimpleBorderRule(classBorderWishList, wishListColor), 0);

    styleSheet.insertRule(createTwoColorStripedBorderRule(classBorderGroupContributorAbove, groupColor, contributorAboveLevelColor), 0);
    styleSheet.insertRule(createTwoColorStripedBorderRule(classBorderGroupContributorBelow, groupColor, contributorBelowLevelColor), 0);
    styleSheet.insertRule(createTwoColorStripedBorderRule(classBorderGroupWishList, groupColor, wishListColor), 0);
    styleSheet.insertRule(createTwoColorStripedBorderRule(classBorderContributorAboveWishList, contributorAboveLevelColor, wishListColor), 0);
    styleSheet.insertRule(createTwoColorStripedBorderRule(classBorderContributorBelowWishList, contributorBelowLevelColor, wishListColor), 0);

    styleSheet.insertRule(createThreeColorStripedBorderRule(classBorderGroupContributorAboveWishList, groupColor, contributorAboveLevelColor, wishListColor), 0);
    styleSheet.insertRule(createThreeColorStripedBorderRule(classBorderGroupContributorBelowWishList, groupColor, contributorBelowLevelColor, wishListColor), 0);
  }

  String createSimpleBorderRule(String className, String color) {
    String rule =
'''
.$className {
  background: $color;
}
''';
    return rule;
  }

  String createTwoColorStripedBorderRule(String className, String color1, String color2) {
    String   rule =
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

  String createThreeColorStripedBorderRule(String className, String color1, String color2, String color3) {
    String   rule =
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
}