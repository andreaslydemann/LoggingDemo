import Foundation

/// Enum which maps an appropiate symbol which added as prefix for each log message
///
/// - info: General  information to log (service start/stop, configuration assumptions, etc).
/// - debug: Information that is helpful to developers to diagnose an issue.
/// - verbose: Use to trace the code, trying to find one part of a function specifically, sort of debugging with extensive information.
/// - warning: Anything that can potentially cause application oddities but an automatic recovery is possible (such as retrying an operation, missing data, etc.)
/// - error: Any error which is fatal to the operation, but not the service or application (can't open a required file, missing data, etc.).
public enum LogEvent: String {
    case info = "[ℹ️]"
    case debug = "[📝]"
    case verbose = "[📣]"
    case warning = "[⚠️]"
    case error = "[☠️]"
}
