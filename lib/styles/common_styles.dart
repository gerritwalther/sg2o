part of sg2o;

/// Class for common styles that are added to the DOM.
class CommonStyles extends Styles {

    CommonStyles() : super ();

    /// Adds a set of common styles to the DOM.
    /// TODO: Maybe move some of the rules to other classes.
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
  width: ${gridViewEntryWidth}px;
  height: ${gridViewEntryHeight}px;
  margin-left: 2.625px;
  margin-right: 2.625px;
  border-radius: 2px;
  margin-bottom: 0.5em;
}
''';
        styleSheet.insertRule(rule, 0);

        styleSheet.insertRule(
            '''
            .$classBorderNone {
                width: auto;
                height: auto;
            }
            ''', 0);

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

        // subtract 12px for border and padding from the width
        rule =
        '''
.$classGridViewInfoContainer {
  z-index: 100;
  font-size: 10;
  border: 1px solid #d2d6e0;
  width: calc(${gridViewEntryWidth}px - 12px);
  display: block;
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
  cursor: pointer;
}
''';
        styleSheet.insertRule(rule, 0);

        styleSheet.insertRule(
            '''
.$classGridViewGAImage {
  height: 100%;
}
''',
        0);

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
  width: 100%;
  text-align: center;
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
  margin-left: 15px;
}
''';
        styleSheet.insertRule(rule, 0);

        rule =
        '''
.$classGiveAwayBlackList {
    cursor: pointer;
    margin-left: 15px;
}
''';
        styleSheet.insertRule(rule, 0);

        rule =
        '''
.$classGAisSGPBlacklisted>i {
    transform: scale(4);
    color: red;
    text-shadow: 0px 0px;
    padding-top: 10px
}
''';
        styleSheet.insertRule(rule, 0);

        rule =
        '''
.$classGAisSGPBlacklisted {
    text-align: center;
}
''';
        styleSheet.insertRule(rule, 0);
    }
}