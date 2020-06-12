// See: https://github.com/andreaslydemann/LoggingDemo

import Foundation

public enum LogEvent: String {
    case verbose = "📣"
    case debug = "📝"
    case info = "ℹ️"
    case warning = "⚠️"
    case error = "☠️"
}

extension LogEvent {
    var logLevel: LogLevel {
        switch self {
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
