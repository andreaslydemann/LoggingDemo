import Foundation

public struct ConsoleLogProvider: LogProvider {
    static var dateFormat = "yyyy-MM-dd HH:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    public func log(_ event: LogEvent, msg: String, file: String, function: String, line: Int) {
        print("\(Date().toString()) \(event.rawValue)[\(file)]:\(line) \(function) -> \(msg)")
    }
}

internal extension Date {
    func toString() -> String {
        return ConsoleLogProvider.dateFormatter.string(from: self as Date)
    }
}

