import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;

class WatchFaceAppApp extends Application.AppBase {

    private var uiTimer = new Timer.Timer();

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        self.uiTimer.start(method(:timerCallback), 1000, true);
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new WatchFaceAppView(), new WatchFaceAppDelegate() ] as Array<Views or InputDelegates>;
    }

    function setUpdateIncrement(increment as Lang.Number) as Void {
        self.uiTimer.stop();
        self.uiTimer.start(method(:timerCallback), increment, true);
    }

    function timerCallback() as Void {
        WatchUi.requestUpdate();
    }
}

function getApp() as WatchFaceAppApp {
    return Application.getApp() as WatchFaceAppApp;
}