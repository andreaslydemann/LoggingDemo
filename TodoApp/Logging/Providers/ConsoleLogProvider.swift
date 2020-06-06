import Foundation

public struct ConsoleLogProvider: LogProvider {
    
    private var dateFormatter: DateFormatter
    
    public init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
    }
    
    public func log(_ event: LogEvent, msg: String, file: String, function: String, line: Int) {
        print("\(dateFormatter.getCurrentDateAsString()) \(event.rawValue)[\(file)]:\(line) \(function) -> \(msg)")
    }
}
