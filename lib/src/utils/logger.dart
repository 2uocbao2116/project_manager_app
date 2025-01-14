class Logger {
  static LogMode _logMode = LogMode.debug;

  static void init(LogMode mode) {
    Logger._logMode = mode;
  }

  static void log(dynamic data, {StackTrace? stackTrace}) {
    if (_logMode == LogMode.debug) {
      print("Error1r: $data$stackTrace");
    }
  }

  static void info(dynamic data) {
    if (_logMode == LogMode.debug) {
      print(data);
    }
  }
}

enum LogMode { debug, live }
