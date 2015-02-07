part of sg2o;

class BorderStyles extends Styles {

  String groupColor = '#308430';
  String contributorAboveLevelColor = '#B80000';
  String contributorBelowLevelColor = '#0033CC';
  String wishListColor = '#9933FF';

  BorderStyles() : super();

  void addBorderStyles() {
    styleSheet.insertRule(createSimpleBorderRule('group', groupColor), 0);
    styleSheet.insertRule(createSimpleBorderRule('contributor-above', contributorAboveLevelColor), 0);
    styleSheet.insertRule(createSimpleBorderRule('contributor-below', contributorBelowLevelColor), 0);
    styleSheet.insertRule(createSimpleBorderRule('wishlist', wishListColor), 0);

    styleSheet.insertRule(createTwoColorStripedBorderRule('group-contributor-above', groupColor, contributorAboveLevelColor), 0);
    styleSheet.insertRule(createTwoColorStripedBorderRule('group-contributor-below', groupColor, contributorBelowLevelColor), 0);
    styleSheet.insertRule(createTwoColorStripedBorderRule('group-wishlist', groupColor, wishListColor), 0);
    styleSheet.insertRule(createTwoColorStripedBorderRule('contributor-above-wishlist', contributorAboveLevelColor, wishListColor), 0);
    styleSheet.insertRule(createTwoColorStripedBorderRule('contributor-below-wishlist', contributorBelowLevelColor, wishListColor), 0);

    styleSheet.insertRule(createThreeColorStripedBorderRule('group-contributor-above-wishlist', groupColor, contributorAboveLevelColor, wishListColor), 0);
    styleSheet.insertRule(createThreeColorStripedBorderRule('group-contributor-below-wishlist', groupColor, contributorBelowLevelColor, wishListColor), 0);
  }

  String createSimpleBorderRule(String className, String color) {
    String rule =
'''
.$className-border {
  background: $color;
}
''';
    return rule;
  }

  String createTwoColorStripedBorderRule(String className, String color1, String color2) {
    String   rule =
'''
.$className-border {
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
.$className-border {
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