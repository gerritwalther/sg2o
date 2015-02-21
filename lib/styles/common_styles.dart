part of sg2o;

class CommonStyles extends Styles {

  CommonStyles() : super ();

  void addStyles() {
    String rule =
  '''
body {
  margin-top: 39px;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
  '''
.$classFixedNavigation {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 9999;
  width: 100%;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
  '''
.$classGridView {
  float: left;
  width: 184px;
  margin-left: 1%;
  margin-right: 1%;
  border-radius: 2px;
  margin-bottom: 0.5em;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
  '''
.$classPinnedGAContainer {
  padding-top: 5px;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
  '''
.$classSectionHeading {
  margin-bottom: 0.5em;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
  '''
.$classGridViewInfoContainer {
  z-index: 100;
  font-size: 10;
  border: 1px solid #d2d6e0;
  width: inherit;
  margin-top: -5.6px;
  border-radius: 3px;
  padding: 5px;
  background: white;
  position: absolute;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
  '''
.$classGridViewAvatar {
  width: 25px;
  height: 25px;
  padding: 2px;
  border: 1px solid #d2d6e0;
  border-radius: 1px;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
  '''
.$classFloatLeft {
  float: left;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
  '''
.$classFloatRight {
  float: right;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
  '''
.$classGridViewGAName {
  font-weight: bold;
  min-height: 30px;
  margin-bottom: 0.5em;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
  '''
.$classHidden {
  display: none !important;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
  '''
.$classFaded {
  opacity: 0.5;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
'''
.$classSg2oTableHeading {
  margin-bottom: 5px;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
'''
.$classOneClickBlackList {
  cursor: pointer;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
'''
.$classCustomWishList {
  cursor: pointer;
  padding-left: 5px;
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
'''
.$classCustomWishList:before {
  content: "\\E11F";
}
''';
    styleSheet.insertRule(rule, 0);

    rule =
'''
.$classHighLightCustomWishList {
  color: #F00;
}
''';
    styleSheet.insertRule(rule, 0);
  }
}