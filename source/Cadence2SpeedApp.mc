import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class Cadence2SpeedApp extends Application.AppBase {
    hidden var view;
    
    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new Cadence2SpeedView() ];
    }

}

function getApp() as Cadence2SpeedApp {
    return Application.getApp() as Cadence2SpeedApp;
}