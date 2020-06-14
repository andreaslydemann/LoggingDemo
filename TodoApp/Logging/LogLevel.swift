import Foundation

public enum LogLevel: Int {
    case verbose, debug, info, warning, error

    var string: String {
        switch self {
        case .verbose:
            return "📣"
        case .debug:
            return "📝"
        case .info:
            return "ℹ️"
        case .warning:
            return "⚠️"
        case .error:
            return "☠️"
        }
    }
}
