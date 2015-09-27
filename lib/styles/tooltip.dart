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
            }
            ''', 0);

        // ###############################################
        // Following the stylesheet for the tooltips for icons on a giveaway.
        styleSheet.insertRule(
            '''
            .$classTooltip {
                outline: none;
                text-decoration: none;
                border-bottom: dotted 1px blue;
                position: relative;
                text-shadow: none;
            }
            ''', 0);

        styleSheet.insertRule(
            '''
            .$classTooltip strong {
                line-height: 30px;
            }
            ''', 0);

        styleSheet.insertRule(
            '''
            .$classTooltip > span {
                width: 300px;
                padding: 10px 20px;
                margin-top: 0;
                margin-left: -120px;
                opacity: 0;
                visibility: hidden;
                z-index: 101;
                position: absolute;
                font-family: Arial;
                font-size: 12px;
                font-style: normal;
                border-radius: 3px;
                box-shadow: 2px 2px 2px #999;
                -webkit-transition-property: opacity, margin-top, visibility, margin-left;
                -webkit-transition-duration: 0.4s, 0.3s, 0.4s, 0.3s;
                -webkit-transition-timing-function: ease-in-out, ease-in-out, ease-in-out, ease-in-out;
                transition-property: opacity, margin-top, visibility, margin-left;
                transition-duration: 0.4s, 0.3s, 0.4s, 0.3s;
                transition-timing-function:
                    ease-in-out, ease-in-out, ease-in-out, ease-in-out;
            }
            ''', 0);

        styleSheet.insertRule(
            '''
            .$classTooltip:hover > span {
                opacity: 1;
                text-decoration: none;
                visibility: visible;
                overflow: visible;
                margin-top: 35px;
                display: inline;
                margin-left: -90px;
            }
            ''', 0);

        styleSheet.insertRule(
            '''
            .$classTooltip span b {
                width: 15px;
                height: 15px;
                margin-left: 55px;
                margin-top: -19px;
                display: block;
                position: absolute;
                -webkit-transform: rotate(-45deg);
                -moz-transform: rotate(-45deg);
                -o-transform: rotate(-45deg);
                transform: rotate(-45deg);
                -webkit-box-shadow: inset -1px 1px 0 #fff;
                -moz-box-shadow: inset 0 1px 0 #fff;
                -o-box-shadow: inset 0 1px 0 #fff;
                box-shadow: inset 0 1px 0 #fff;
                display: none\0/;
                *display: none;
            }
            ''', 0);

        styleSheet.insertRule(
            '''
            .$classTooltip > span {
                color: #FFFFFF;
                background: #333333;
                background: -webkit-linear-gradient(top, rgb(81, 87, 99), rgb(47, 53, 64));
                background: linear-gradient(top, rgb(81, 87, 99), rgb(47, 53, 64));
                border: 1px solid #000000;
            }
            ''', 0);

        styleSheet.insertRule(
            '''
            .$classTooltip span b {
                background: rgb(81, 87, 99);
                border-top: 1px solid #000000;
                border-right: 1px solid #000000;
            }
            ''', 0);
    }
}