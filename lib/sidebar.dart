part of sg2o;

/// Class for the sidebar which is present on most (or all) of the pages
class SideBar {
    int offsetTop;

    SideBar() {
        Element sidebarElement = querySelector('.$classSidebar');
        this.offsetTop = sidebarElement.offset.top;
    }

    /// Returns [true] if the sidebar is present.
    bool isSidebarPresent() {
        return querySelectorAll('.$classSidebar').length >= 1;
    }

    /// Adds a class to the [SideBar] to fix it.
    void fixSidebar() {
        Element sidebarElement = querySelector('.$classSidebar');

        window.onScroll.listen(moveSidebar);
    }

    /// Moves the sidebar to be always visible and at the same position.
    void moveSidebar(Event e) {
        Element sidebarElement = querySelector('.$classSidebar');

        if (document.body.scrollTop + 39 > offsetTop) {
            /* 25px for the inner page container, 39px for the nav-bar. */
            sidebarElement.setAttribute('style', 'margin-top:' + (25 + 39 + document.body.scrollTop - offsetTop).toString() + 'px;');
        } else {
            sidebarElement.setAttribute('style', 'margin-top: 0px;');
        }
    }
}