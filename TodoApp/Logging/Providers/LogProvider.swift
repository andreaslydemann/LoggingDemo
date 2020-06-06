import Foundation

public protocol LogProvider {
    func log(_ event: LogEvent, message: String, file: String, function: String, line: Int)
}
