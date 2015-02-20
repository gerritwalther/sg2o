part of sg2o;

/// User belonging constants

int myLevel = getUserLevel();

///

const String pluginName = 'SG₂O';

/// classes defined by sg

const String classPinnedGiveaways = 'pinned-giveaways';
const String classGiveawayRow =  'giveaway__row-outer-wrap';
const String classFeaturedContainer = 'featured__container';
const String classFeaturedOuterWrap = 'featured__outer-wrap--home';
const String classWidgetContainers = 'widget-container';
const String classSectionHeading = 'page__heading';
const String classPoints = 'nav__points';
const String classLeftNavigation = 'nav__left-container';
const String classNavigationButtonContainer = 'nav__button-container';
const String classNavigationButton = 'nav__button';
const String classSidebar = 'sidebar';

const String classGAHeadingThin = 'giveaway__heading__thin';
const String classGAName = 'giveaway__heading__name';
const String classGAColumns = 'giveaway__columns';
const String classGAColumnWidthFill = 'giveaway__column--width-fill';
const String classGAUserName = 'giveaway__username';
const String classGALinks = 'giveaway__links';
const String classGAGameImage = 'global__image-outer-wrap--game-medium';
const String classGAAvatar = 'global__image-outer-wrap--avatar-small';
const String classGAAvatarImage = 'global__image-inner-wrap';
const String classGAContributorLvl = 'giveaway__column--contributor-level';
const String classGAContributorPos = 'giveaway__column--contributor-level--positive';
const String classGAContributorNeg = 'giveaway__column--contributor-level--negative';
const String classGAGroupIcon = 'giveaway__column--group';
const String classGAEntered = 'is-faded';
const String classGAImageOuterBorder = 'global__image-outer-wrap';
const String classGAWhiteListed = 'giveaway__column--whitelist';
const String classGAHide = 'giveaway__hide';
const String classEyeSlash = 'fa-eye-slash';

const String classWidgetMarginTop = 'widget-container--margin-top';

const String classPagination = 'pagination';
const String classPaginationNavigation = 'pagination__navigation';
const String classPageHeadingBreadCrumbs = 'page__heading__breadcrumbs';

const String classTableColumnWidthFill = 'table__column--width-fill';
const String classTableHeading = 'table__heading';

const String classWishListName = 'table__column__heading';

/// elements defined by sg

const String elementNavigation = 'header';

/// classes added by sg2o

const String classPinnedGAContainer = 'pinned-gridview-container';
const String classGridViewContainer = 'gridview-container';
const String classGridView = 'giveaway-gridview';
const String classFixedNavigation = 'fixed-navigation-bar';
const String classHidden = 'hidden';
const String classFaded = 'faded';
const String classGridViewInfoContainer = 'gridview-info';
const String classGridViewAvatar = 'gridview-avatar';
const String classGridViewGAName = 'ga-name';
const String classOneClickBlackList = 'sg2o-blacklist-ga';

const String classSg2oTableHeading = 'sg2o-table-heading';

const String classFloatLeft = 'float-left';
const String classFloatRight = 'float-right';

const String classBorderGroup = 'group-border';
const String classBorderContributorAbove = 'contributor-above-border';
const String classBorderGroupContributorAbove = 'group-contributor-above-border';
const String classBorderContributorBelow = 'contributor-below-border';
const String classBorderGroupContributorBelow = 'group-contributor-below-border';
const String classBorderWishList = 'wishlist-border';
const String classBorderGroupWishList = 'group-wishlist-border';
const String classBorderContributorAboveWishList = 'contributor-above-wishlist-border';
const String classBorderGroupContributorAboveWishList = 'group-contributor-above-wishlist';
const String classBorderContributorBelowWishList = 'contributor-below-wishlist';
const String classBorderGroupContributorBelowWishList = 'group-contributor-below-wishlist';
const String classBorderWhiteList = 'whitelist';
const String classBorderWhiteListGroup = 'whitelist-group';
const String classBorderWhiteListContributorAbove = 'whitelist-contributor-above';
const String classBorderWhiteListGroupContributorAbove = 'whitelist-group-contributor-above';
const String classBorderWhiteListContributorBelow = 'whitelist-contributor-below';
const String classBorderWhiteListGroupContributorBelow = 'whitelist-group-contributor-below';
const String classBorderWhiteListWishList = 'whitelist-wishlist';
const String classBorderWhiteListGroupWishList = 'whitelist-group-wishlist';
const String classBorderWhiteListWishListContributorAbove = 'whitelist-wishlist-contributor-above';
const String classBorderWhiteListGroupWishListContributorAbove = 'whitelist-group-wishlist-contributor-above';
const String classBorderWhiteListWishListContributorBelow = 'whitelist-wishlist-contirbutor-below';
const String classBorderWhiteListWishListGroupContributorBelow = 'whitelist-wishlist-group-contributor-below';

const String classSettingsOverlay = 'sg2o-overlay-settings';
const String classClose = 'sg2o-close';
const String classModalDialog = 'sg2o-modal-dialog';
const String classSettingsHeading = 'sg2o-settings-head';

const String classFormRow = 'form__row';
const String classFormHeading = 'form__heading';
const String classFormHeadingText = 'form__heading__text';
const String classFormRowIndent = 'form__row__indent';
const String classFormCheckbox = 'form__checkbox';
const String classFormCheckboxDefault = 'form__checkbox__default';
const String classFormCheckboxHover = 'form__checkbox__hover';
const String classFormCheckboxSelected = 'form__checkbox__selected';
const String classFA = 'fa';
const String classFACircle = 'fa-circle';
const String classFACircleO = 'fa-circle-o';
const String classFACheckedCircle = 'fa-check-circle';

const String classIsSelected = 'is-selected';
const String classIsDisabled = 'is-disabled';

/// URLs
const String urlSteamGiftsHome = 'http://www.steamgifts.com/';
const String urlGiveAwayPage = '/giveaways/search?page=';
const String urlSteamWishList = '/account/steam/wishlist/search?page=';

/// Storage related constants
const String keyName = 'sg2o-';
const String keyNameTimestamp = '-timestamp';
const num daysForExpiration = 365;

const String keyHideGAs = 'hide-giveaways';
const String keyWishList = 'wishlist';

const String oldFilterKey = 'lscache-sgpgiveawayFilters';

/// Colors
const String groupColor = '#308430';
const String contributorAboveLevelColor = '#B80000';
const String contributorBelowLevelColor = '#0033CC';
const String wishListColor = '#9933FF';
const String whiteListColor = '#00EBF7';
const String fontColor = '#324862';

/// numbers
const num oneDay = 1000 * 60 * 60 * 24;