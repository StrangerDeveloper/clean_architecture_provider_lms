import 'package:flutter/foundation.dart' show debugPrint;

/// Extension on Object to provide a convenient and enhanced logging method.
extension Log on Object{
  /// Logs the string representation of the object using debugPrint with
  /// additional context like file name and line number.
  ///
  /// This method converts the object to a string and prints it to the
  /// console along with optional debug context information.
  void logs({String tag = "Nuevo--Log"}){
    final stackTrace = StackTrace.current;
    final location = _getCallerLocation(stackTrace);
    debugPrint('[$tag] $this (at $location)');
  }

  /// Logs the string representation of the object as an error using debugPrint.
  /// Displays the log in red color (console environments) with additional context.
  void logError(){
    final stackTrace = StackTrace.current;
    final location = _getCallerLocation(stackTrace);

    debugPrint('⛔⛔ => $this (at $location) <= ⛔⛔');
  }

  /// Extracts the file name and line number from the stack trace.
  String _getCallerLocation(StackTrace stackTrace){
    final stackTraceLines = stackTrace.toString().split('\n');
    if(stackTraceLines.length > 1){
      final callerLine = stackTraceLines[1];
      final locationMatch = RegExp(r'[^/]+\.dart:\d+:\d+').firstMatch(callerLine);
      if (locationMatch != null) {
        return locationMatch.group(0) ?? "Unknown location";
      }
    }
    return "Unknown location";
  }
}