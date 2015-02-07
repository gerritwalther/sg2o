part of SGv2plus;

void addBorderStyles() {
  CssStyleSheet styleSheet = createStyleSheetElement();

  String groupColor = '#308430';
  String contributorAboveLevelColor = '#B80000';
  String contributorBelowLevelColor = '#0033CC';
  String wishListColor = '#9933FF';
  String rule;

  rule = createSimpleBorderRule('group', groupColor);
  styleSheet.insertRule(rule, 0);

  rule = createSimpleBorderRule('contributor-above', contributorAboveLevelColor);
  styleSheet.insertRule(rule, 0);

  rule = createSimpleBorderRule('contributor-below', contributorBelowLevelColor);
  styleSheet.insertRule(rule, 0);

  rule = createSimpleBorderRule('wishlist', wishListColor);
  styleSheet.insertRule(rule, 0);

  rule = createTwoColorStripedBorderRule('group-contributor-above', groupColor, contributorAboveLevelColor);
  styleSheet.insertRule(rule, 0);

  rule = createTwoColorStripedBorderRule('group-contributor-below', groupColor, contributorBelowLevelColor);
  styleSheet.insertRule(rule, 0);

  rule = createTwoColorStripedBorderRule('group-wishlist', groupColor, wishListColor);
  styleSheet.insertRule(rule, 0);

  rule = createTwoColorStripedBorderRule('contributor-above-wishlist', contributorAboveLevelColor, wishListColor);
  styleSheet.insertRule(rule, 0);

  rule = createTwoColorStripedBorderRule('contributor-below-wishlist', contributorBelowLevelColor, wishListColor);
  styleSheet.insertRule(rule, 0);

  rule = createThreeColorStripedBorderRule('group-contributor-above-wishlist', groupColor, contributorAboveLevelColor, wishListColor);
  styleSheet.insertRule(rule, 0);

  rule = createThreeColorStripedBorderRule('group-contributor-below-wishlist', groupColor, contributorBelowLevelColor, wishListColor);
  styleSheet.insertRule(rule, 0);
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