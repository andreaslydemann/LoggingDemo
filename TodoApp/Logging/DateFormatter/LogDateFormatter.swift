import Foundation

final public class LogDateFormatter: DateFormatter {
    convenience init(dateFormat: String = "yyyy-MM-dd HH:mm:ssSSS") {
        self.init()
        self.dateFormat = dateFormat
        self.locale = Locale.current
        self.timeZone = TimeZone.current
    }
}

extension DateFormatter {
    func getCurrentDateAsString() -> String {
        return self.string(from: Date())
    }
}
