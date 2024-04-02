part of sg2o;

class SettingsWishList implements SettingsTab {

    late ParagraphElement pageContainer;

    Element createPage() {
        pageContainer = new ParagraphElement();
        pageContainer
            ..append(SGButton().create('fa-refresh', 'Resync wishlist from profile!', reSyncWishList))
        ;

        return pageContainer;
    }

    void reSyncWishList(Event e) {
        wishList.loadWishListFromProfile(1);
        pageContainer.append(InfoElement().create('Resynced wishlist!'));
    }

    void select() {
        pageContainer.parent?.classes.add(classSettingsTabSelected);
    }
}