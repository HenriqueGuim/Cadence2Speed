class Speed {
  hidden var cadence;             // rpm
  hidden var wheelCircumference;  // mm
  var chainringSize;              // teeth
  var cogSize;                    // teeth

  function initialize() {
    cadence = 0;
    configure();
    System.println("Configured speed with chainring = " + chainringSize +
                   ", cog = " + cogSize + ", wheel size = " + wheelCircumference);
  }

  private function configure() {
    if (Application has : Properties) {
      chainringSize =
          Application.Properties.getValue("chainringSize").toDouble();
      cogSize = Application.Properties.getValue("cogSize").toDouble();
      wheelCircumference =
          Application.Properties.getValue("wheelCircumference").toDouble();
    } else {
      chainringSize = 48.0;
      cogSize = 17.0;
      wheelCircumference = 2105.0;
    }
  }

  function set(currentRpm) {
    cadence = currentRpm;
    return self;
  }
    // Calculate the speed in m/s
  function speedKph() { return cadence <= 0 ? 0.0 : ((cadence * wheelCircumference) /60000) * (chainringSize/cogSize) ; }

}