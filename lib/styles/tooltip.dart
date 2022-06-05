part of sg2o;

/// Class for tooltip styles.
class Tooltip extends Styles {

    Tooltip() : super();

    /// Adds all border styles to the DOM.
    void addStyles() {

        // This is only for the profile tooltip when hovering over the avatar on a giveaway.
        styleSheet.insertRule(
            '''
            .$classProfileTooltip {
                width: 550px;
                padding: 5px;
            }
            ''', 0);

        styleSheet.insertRule(
            '''
            #$classProfileTooltipContainer {
                width: 560px;
                height: 195px;
                display: flex;
                justify-content: center;
                align-items: center;
                display:none;
            }
            ''', 0);
    }
}