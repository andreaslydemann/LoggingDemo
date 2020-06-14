import Foundation

public struct ConsoleLogProvider: LogProvider {
    
    private var dateFormatter: DateFormatter
    
    public init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
    }
    
    public func log(_ logLevel: LogLevel, message: String, file: String, function: String, line: Int) {
        print("[\(logLevel.string)) \(dateFormatter.getCurrentDateAsString()) \(file):\(function):\(line)] \(message)")
    }
}
