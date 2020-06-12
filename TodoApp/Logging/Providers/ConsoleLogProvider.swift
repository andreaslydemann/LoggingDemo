import Foundation

public struct ConsoleLogProvider: LogProvider {
    
    public var logLevel: LogLevel
    private var dateFormatter: DateFormatter
    
    public init(dateFormatter: DateFormatter, logLevel: LogLevel = .all) {
        self.dateFormatter = dateFormatter
        self.logLevel = logLevel
    }
    
    public func log(_ event: LogEvent, message: String, file: String, function: String, line: Int) {
        print("[\(event.rawValue) \(dateFormatter.getCurrentDateAsString()) \(file):\(function):\(line)] \(message)")
    }
}
