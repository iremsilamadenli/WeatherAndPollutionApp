class StateManager {
  bool isWeatherSelected = false;

  // Singleton pattern for a global instance
  static final StateManager _instance = StateManager._internal();

  factory StateManager() {
    return _instance;
  }

  StateManager._internal();
}