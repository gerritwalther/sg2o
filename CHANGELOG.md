# Changelog

## 0.3.0
- Added steam link to the giveaway entries on the gridview (#90)
- Added navigation menu to the sg2o button in the top bar
  - SG₂O button leads to the discussion thread
  - in the dropdown there are links to settings and a simple about page (#123)
- Using PowerTip (jQuery) instead of custom tooltip (#109)
- Fixed an issue with games not having a steam link (#149)
- Fixed settings can't be deactivated (#155)
- Move left side ads below filters

## 0.2.21
- Fix gridview after some restyling of cg.
- Show colored borders correctly
- Increase opacity of entered GAs when hovering over them.

## 0.2.20
- Fix games not shown as entered (faded).
- Fix games without error to create an error when parsing its image url.

## 0.2.19
- Fixed gridview after restyling of game images and user avatar on the giveaway page.
- Fixed width on the gridview page.

## 0.2.18
- Partially reverted the changes from 0.2.17 and now use fixed width again.

## 0.2.17
- Refactored CSS to get 5 instead of 4 games per row in the gridview (now using percentages).

## 0.2.16
- Fixed the requests for my scripts to use HTTPS as well.

## 0.2.15
- SG is now using HTTPS, adapted the script for it.

## 0.2.14
- Bugfix for broken one-click hiding.

## 0.2.13
- Bugfix for broken gridview: cg moved the game id.

## 0.2.12
- Added tooltips to the avatar on each giveaway.
- Instead of hiding games from the SG+ Blacklist they get a red ban icon on top of the image.
- Bugfix: Filtering didn't work with deactivated automatic adding of SG+ blacklisted games and if there were games that are on that list.
- Bugfix: Games with some special characters were not highlighted if they are on the wishlist.
- Bugfix: Getting an empty search result caused the script to not work anymore.
- Bugfix: Removed warnings from JS console that were produced by the profile tooltip.

## 0.2.11
- Fixed a bug to also consider querying for a game.

## 0.2.7
- Fixed a bug where the sliders to select the time for new giveaways were missing.

## 0.2.6
- Fixed a bug where filter did not work with hidden, entered giveaways.
- Regular check for loading further pages.
- Open creator profile on leftclick on avatar.
- Open giveaway page on leftclick on avatar.

## 0.2.5
- Fixed a bug where slider was on 2.9000004 instead of 3.0.
- Making SG2O more compatible with Dark Theme.

## 0.2.4
- Fixed loading of JS files for Firefox.
- Lowered steps for chance slider to 0.1% and range to 0 to 3 % instead of 0 to 100 %.

## 0.2.3
- Update URLs fixed.

## 0.2.2
- Fixed removal of dropdown button.

## 0.2.1
- Fixed loading of pips.

## 0.2.0
- Temporary filter for giveaways -> Hides giveaways by ID. A new button is added to the gridview (sad smiley).
- Filter for gridview: filter gridview by contributor level, points or chance.
- Reload page when closing settings.
- Added tooltips to the buttons in the gridview dropdowns.
- New Settings:
-- Change color of border colors.
-- Resync button for the local wishlist.
-- Do/Don't move discussions to top.
-- Enable/Disable removal of featured giveaways.
-- Enable/Disable reload of page when closing settings.

## 0.1.4
- Fixed gridview.

## 0.1.3
- Fixed endless scroll for wishlist/group/new giveaways.

## 0.1.2
- Enabling SSL for the script.

## 0.1.1
- Only one checkbox for hiding giveaways setting.
- Added option for automatic blacklisting of games.

## 0.1.0
- Gridview.
- Colored borders. Blue (meets own contributor level), red (above own contributor level), green (group), purple (wishlist), turquoise (whitelist).
- One-click blacklisting of games.
- Automatic blacklisting of games that were on the blacklist in SG+.
- Endless-scroll for giveaway page.
- Loads wishlist from profile once a day.
- Custom wishlist for games that can not be wished for on Steam.
- Setting to hide entered game.
- Fixed navbar (all pages).
- Fixed sidebar (all pages).
- Removed featured giveaway.
- Recent forum posts on top.
