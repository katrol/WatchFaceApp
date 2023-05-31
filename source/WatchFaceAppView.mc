import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Sensor;
import Toybox.SensorHistory;
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

        var sensInfo = Sensor.getInfo();
        view = View.findDrawableById("AltitudeLabel") as Text;
        view.setText(sensInfo.altitude.format("%.1f"));

        var temp = sensInfo.temperature;
        view = View.findDrawableById("TempLabel") as Text;
        if (temp != null) {
            view.setText(temp.format("%.1f"));
        }
        else {
            view.setText("--");
        }
        // view.setText(globalTemp.format("%f"));

        var hr = sensInfo.heartRate;
        view = View.findDrawableById("HrLabel") as Text;
        if (hr != null) {
            view.setText(hr.format("%d"));
        }
        else {
            view.setText("--");
        }

        view = View.findDrawableById("StressLabel") as Text;
        var stress = SensorHistory.getStressHistory({:period => 1});
        if (stress != null) {
            stress = stress.next();
        }
        if (stress != null) {
            stress = stress.data;
        }
        if (stress != null) {
            view.setText(stress.format("%d"));
        }
        else {
            view.setText("--");
        }

        view = View.findDrawableById("BbLabel") as Text;
        var bb = SensorHistory.getBodyBatteryHistory({:period => 1});
        if (bb != null) {
            bb = bb.next();
        }
        if (bb != null) {
            bb = bb.data;
        }
        if (bb != null) {
            view.setText(bb.format("%d"));
        }
        else {
            view.setText("--");
        }

        var bat = System.getSystemStats().battery;
        view = View.findDrawableById("BatteryLabel") as Text;
        view.setText(bat.format("%.1f"));

        var devSettings = System.getDeviceSettings();
        view = View.findDrawableById("NotificationLabel") as Text;
        view.setText(devSettings.notificationCount.format("%d"));
        view = View.findDrawableById("AlarmLabel") as Text;
        view.setText(devSettings.alarmCount.format("%d"));

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