part of sg2o;

class SideBar {
  int offsetTop;

  SideBar () {
    Element sidebarElement = querySelector('.$classSidebar');
    this.offsetTop = sidebarElement.offset.top;
  }

  bool isSidebarPresent() {
    return querySelectorAll('.$classSidebar').length >= 1;
  }

  void fixSidebar() {
    Element sidebarElement = querySelector('.$classSidebar');

    window.onScroll.listen(moveSidebar);
  }

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