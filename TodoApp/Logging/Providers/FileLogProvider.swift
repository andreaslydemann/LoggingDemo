import Foundation

public struct FileLogProvider: LogProvider {
    
    private var dateFormatter: DateFormatter
    public var fileWriter: FileWriter
    public var logLevel: LogLevel
    
    public init(dateFormatter: DateFormatter, fileWriter: FileWriter, logLevel: LogLevel = .all) {
        self.dateFormatter = dateFormatter
        self.fileWriter = fileWriter
        self.logLevel = logLevel
        
    }
    
    public func log(_ event: LogEvent, message: String, file: String, function: String, line: Int) {
        fileWriter.write("[\(event.rawValue) \(dateFormatter.getCurrentDateAsString()) \(file):\(function):\(line)] \(message)")
    }
}
