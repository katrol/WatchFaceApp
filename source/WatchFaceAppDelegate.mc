import Toybox.Lang;
import Toybox.WatchUi;

class WatchFaceAppDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.PowerMenu(), new WatchFaceAppMenuDelegate(), WatchUi.SLIDE_LEFT);
        return true;
    }

    function onSelect() as Boolean {
        WatchUi.pushView(new Rez.Menus.PowerMenu(), new WatchFaceAppMenuDelegate(), WatchUi.SLIDE_LEFT);
        return true;
    }

}