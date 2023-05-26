import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Sensor;
import Toybox.Time;
import Toybox.ActivityMonitor;

class WatchFaceAppView extends WatchUi.View {

    var gSensorInfo;
    function initialize() {
        View.initialize();
        Sensor.setEnabledSensors([Sensor.SENSOR_TEMPERATURE, Sensor.SENSOR_HEARTRATE]);
        Sensor.enableSensorEvents(method(:onSensor));
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        var time = Time.Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);

        var view = View.findDrawableById("TimeLabel") as Text;
        view.setText(time.hour + ":" + time.min.format("%02u"));
        view = View.findDrawableById("SecLabel") as Text;
        view.setText(time.sec.format("%02u"));
        view = View.findDrawableById("DateLabel") as Text;
        view.setText(time.day + " " + time.month);

        view = View.findDrawableById("TempLabel") as Text;
        var temp = Sensor.getInfo().temperature;
        if (temp != null) {
            view.setText(temp.format("%.1f"));
        }
        else {
            view.setText("--");
        }
        // view.setText(globalTemp.format("%f"));

        view = View.findDrawableById("HrLabel") as Text;
        var hr = Sensor.getInfo().heartRate;
        if (hr != null) {
            view.setText(hr.format("%d"));
        }
        else {
            view.setText("--");
        }

        view = View.findDrawableById("BatteryLabel") as Text;
        var bat = System.getSystemStats().battery;
        view.setText(bat.format("%.1f"));

        view = View.findDrawableById("NotificationLabel") as Text;
        var not = System.getDeviceSettings().notificationCount;
        view.setText(not.format("%d"));

        var actInfo = ActivityMonitor.getInfo();
        view = View.findDrawableById("StepsLabel") as Text;
        view.setText(actInfo.steps.format("%d"));
        view = View.findDrawableById("CalLabel") as Text;
        view.setText(actInfo.calories.format("%d"));

        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }


    function onSensor(sensorInfo as Sensor.Info) as Void {
        gSensorInfo = sensorInfo;
        // WatchUi.requestUpdate();
    }
}