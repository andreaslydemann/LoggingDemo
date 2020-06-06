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
    
    func info(_ object: Any, filename: String = #file, funcName: String = #function, line: Int = #line) {
        LogService.providers.forEach {
            $0.log(.info, message: ("\(object)"), file: LogService.fileName(filePath: filename), function: funcName, line: line)
        }
    }
    
    func debug(_ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        LogService.providers.forEach {
            $0.log(.debug, message: ("\(object)"), file: LogService.fileName(filePath: filename), function: funcName, line: line)
        }
    }
    
    func verbose(_ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        LogService.providers.forEach {
            $0.log(.verbose, message: ("\(object)"), file: LogService.fileName(filePath: filename), function: funcName, line: line)
        }
    }
    
    func warning(_ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        LogService.providers.forEach {
            $0.log(.warning, message: ("\(object)"), file: LogService.fileName(filePath: filename), function: funcName, line: line)
        }
    }
    
    func error(_ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        LogService.providers.forEach {
            $0.log(.error, message: ("\(object)"), file: LogService.fileName(filePath: filename), function: funcName, line: line)
        }
    }
    
    private static func fileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}
