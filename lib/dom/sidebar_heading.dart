part of sg2o;

class SideBarHeading extends HeadingElement {

    factory SideBarHeading(String content) {
        HeadingElement heading = new HeadingElement.h3()
            ..classes.add(classSidebarHeading)
            ..text = content
        ;
        return heading as SideBarHeading;
    }
}
