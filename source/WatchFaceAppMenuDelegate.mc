import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WatchFaceAppMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        var increment;
        switch (item.getId()){
            case :item_minute:
                increment = 60000;
                break;
            case :item_second:
            default:
                increment = 1000;
                break;
        }

        getApp().setUpdateIncrement(increment);

        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }

}