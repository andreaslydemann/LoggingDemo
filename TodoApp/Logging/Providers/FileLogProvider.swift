import Foundation

public struct FileLogProvider: LogProvider {
    
    private var dateFormatter: DateFormatter
    private var fileWriter: FileWriter
    
    public init(dateFormatter: DateFormatter, fileWriter: FileWriter) {
        self.dateFormatter = dateFormatter
        self.fileWriter = fileWriter
    }
    
    public func log(_ event: LogEvent, message: String, file: String, function: String, line: Int) {
        fileWriter.write("[\(event.rawValue) \(dateFormatter.getCurrentDateAsString()) \(file):\(function):\(line)] \(message)")
    }
}
