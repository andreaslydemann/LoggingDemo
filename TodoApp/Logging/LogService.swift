import Foundation

public final class LogService {
    private static var providers = [LogProvider]()
    
    static let shared = LogService(providers: providers)
    
    private init(providers: [LogProvider]) {
        LogService.providers = providers
    }
    
    static func register(provider: LogProvider) {
        providers.append(provider)
    }
    
    func info(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        LogService.providers.forEach {
            $0.log(.info, msg: ("\(object)"), file: LogService.sourceFileName(filePath: filename), function: funcName, line: line)
        }
    }
    
    func debug(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        LogService.providers.forEach {
            $0.log(.debug, msg: ("\(object)"), file: LogService.sourceFileName(filePath: filename), function: funcName, line: line)
        }
    }
    
    func verbose(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        LogService.providers.forEach {
            $0.log(.verbose, msg: ("\(object)"), file: LogService.sourceFileName(filePath: filename), function: funcName, line: line)
        }
    }
    
    func warning(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        LogService.providers.forEach {
            $0.log(.warning, msg: ("\(object)"), file: LogService.sourceFileName(filePath: filename), function: funcName, line: line)
        }
    }
    
    func error(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        LogService.providers.forEach {
            $0.log(.error, msg: ("\(object)"), file: LogService.sourceFileName(filePath: filename), function: funcName, line: line)
        }
    }
    
    private static func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}
