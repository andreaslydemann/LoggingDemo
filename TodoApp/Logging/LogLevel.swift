import Foundation

public enum LogLevel: Int {
    case all = 0, verbose, debug, info, warning, error
}

extension LogLevel {
    var logEvent: LogEvent {
        switch self {
        case .all:
            return .verbose
        case .verbose:
            return .verbose
        case .debug:
            return .debug
        case .info:
            return .info
        case .warning:
            return .warning
        case .error:
            return .error
        }
    }
}
