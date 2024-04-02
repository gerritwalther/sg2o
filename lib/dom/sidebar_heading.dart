part of sg2o;

class SideBarHeading {
    factory SideBarHeading() => SideBarHeading._internal();

    SideBarHeading._internal();

    HeadingElement create(String content) {
        HeadingElement heading = new HeadingElement.h3()
            ..classes.add(classSidebarHeading)
            ..text = content
        ;
        return heading;
    }
}
