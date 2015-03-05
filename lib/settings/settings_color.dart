part of sg2o;

class SettingsColor implements SettingsTab {

    ParagraphElement pageContainer;

    Element createPage() {
        pageContainer = new ParagraphElement();

        return pageContainer;
    }

    void select() {
        pageContainer.parent.classes.add(classSettingsTabSelected);
    }

}