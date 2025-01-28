using Toybox.WatchUi;
using Toybox.System;
using Toybox.FitContributor;
using Toybox.Math;

class SpeedFitContributor {
  hidden var currentSpeedField;
  hidden var lapAvgSpeedField;
  hidden var sessionAvgSpeedField;
  hidden var lapMaxSpeedField;
  hidden var sessionMaxSpeedField;
  hidden var lapStats;
  hidden var sessionStats;
  hidden var timerRunning;

  function initialize(dataField) {
    currentSpeedField = dataField.createField(
      "speed", 0, FitContributor.DATA_TYPE_UINT8,
      {
      :nativeNum => 6,
      :mesgType  => FitContributor.MESG_TYPE_RECORD,
      :units     => "m/s"
      }
    );

    lapAvgSpeedField = dataField.createField(
      "avg_speed", 1, FitContributor.DATA_TYPE_UINT8,
      {
      :nativeNum => 13,
      :mesgType  => FitContributor.MESG_TYPE_LAP,
      :units     => "m/s"
      }
    );

    lapMaxSpeedField = dataField.createField(
      "max_speed", 2, FitContributor.DATA_TYPE_UINT8,
      {
      :nativeNum => 14,
      :mesgType  => FitContributor.MESG_TYPE_LAP,
      :units     => "m/s"
      }
    );

    sessionAvgSpeedField = dataField.createField(
      "avg_speed", 3, FitContributor.DATA_TYPE_UINT8,
      {
      :nativeNum => 14,
      :mesgType  => FitContributor.MESG_TYPE_SESSION,
      :units     => "m/s"
      }
    );

    sessionMaxSpeedField = dataField.createField(
      "max_cadence", 4, FitContributor.DATA_TYPE_UINT8,
      {
      :nativeNum => 15,
      :mesgType  => FitContributor.MESG_TYPE_SESSION,
      :units     => "m/s"
      }
    );

    lapStats = new Stats();
    sessionStats = new Stats();

    timerRunning = true;
    compute(0);  // initialize with zero
    timerRunning = false;
  }

  function compute(speedValue) {
    if (!timerRunning) {
      return;
    }

    currentSpeedField.setData(speedValue);

    lapStats.add(speedValue);
    sessionStats.add(speedValue);

    lapAvgSpeedField.setData(lapStats.average());
    lapMaxSpeedField.setData(lapStats.maximum());

    sessionAvgSpeedField.setData(sessionStats.average());
    sessionMaxSpeedField.setData(sessionStats.maximum());

    System.println(
      "Fit: cadence = " + speedValue +
        ", lapAvg = " + lapStats.average() +
        ", lapMax = " + lapStats.maximum() +
        ", sessionAvg = " + sessionStats.average() +
        ", sessionMax = " + sessionStats.maximum());
  }

  function setTimerRunning(enabled) { timerRunning = enabled; }

  function onTimerReset() {
    System.println("timer reset");
    sessionStats.reset();
  }

  function onTimerLap() {
    System.println("timer lap");
    lapStats.reset();
  }
}
