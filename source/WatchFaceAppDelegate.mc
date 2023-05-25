import Toybox.Lang;
import Toybox.WatchUi;

class WatchFaceAppDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new WatchFaceAppMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}