part of sg2o;

class SettingsWishList implements SettingsTab {

    ParagraphElement pageContainer;

    Element createPage() {
        pageContainer = new ParagraphElement();
        pageContainer
            ..append(new SGButton('fa-refresh', 'Resync wishlist from profile!', reSyncWishList))
        ;

        return pageContainer;
    }

    void reSyncWishList(Event e) {
        wishList.loadWishListFromProfile(1);
    }

    void select() {
        pageContainer.parent.classes.add(classSettingsTabSelected);
    }
}