import Foundation

public struct ConsoleLogProvider: LogProvider {
    
    private var dateFormatter: DateFormatter
    
    public init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
    }
    
    public func log(_ event: LogEvent, message: String, file: String, function: String, line: Int) {
        print("[\(event.rawValue) \(dateFormatter.getCurrentDateAsString()) \(file):\(function):\(line)] \(message)")
    }
}
