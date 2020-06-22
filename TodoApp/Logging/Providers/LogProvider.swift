import Foundation

public protocol LogProvider {
    func log(_ event: LogLevel, message: String, file: String, function: String, line: Int)
}
