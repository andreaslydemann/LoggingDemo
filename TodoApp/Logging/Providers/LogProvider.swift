import Foundation

public protocol LogProvider {
    
    var logLevel: LogLevel { get }
    
    func log(_ event: LogEvent, message: String, file: String, function: String, line: Int)
}
