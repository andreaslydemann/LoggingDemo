import Foundation

public struct FileLogProvider: LogProvider {
    
    private var dateFormatter: DateFormatter
    public var fileWriter: FileWriter
    
    public init(dateFormatter: DateFormatter, fileWriter: FileWriter) {
        self.dateFormatter = dateFormatter
        self.fileWriter = fileWriter
    }
    
    public func log(_ logLevel: LogLevel, message: String, file: String, function: String, line: Int) {
        fileWriter.write("[\(logLevel.string) \(dateFormatter.getCurrentDateAsString()) \(file):\(function):\(line)] \(message)")
    }
}
