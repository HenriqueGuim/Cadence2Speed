import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class Cadence2SpeedView extends WatchUi.SimpleDataField {
    enum {
    CONFIG,
    CADENCE,
    SPEED,
  }

  hidden var speed;
  hidden var speedValue = 0;
  hidden var fitContributor;

    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();
        label = "Speed";
        speed = new Speed();
        fitContributor = new SpeedFitContributor(self);
    }

    // The given info object contains all the current workout
    // information. Calculate a value and return it in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Numeric or Duration or String or Null {
        if(info has :currentCadence){
            if (info.currentCadence != null) {
                speed.set(info.currentCadence);
                speedValue = speed.speedKph()*3.6;
                fitContributor.compute(speedValue*3.6);
            } else {
                speedValue = 0.0 ;
            }
        }
        var intSpeedValue = speedValue; // Cast speedValue to an integer
        return Lang.format("$1$ km/h", [intSpeedValue.format("%.2f")]);
    }

    function onTimerStart() { fitContributor.setTimerRunning(true); }

    function onTimerStop() { fitContributor.setTimerRunning(false); }

    function onTimerPause() { fitContributor.setTimerRunning(false); }

    function onTimerResume() { fitContributor.setTimerRunning(true); }

    function onTimerLap() { fitContributor.onTimerLap(); }

    function onTimerReset() { fitContributor.onTimerReset(); }

    

}