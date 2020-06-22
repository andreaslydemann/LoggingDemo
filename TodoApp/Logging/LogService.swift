import Foundation

public final class LogService {
    public static var providers = [LogProvider]()
    
    static public let shared = LogService(providers: providers)
    
    private init(providers: [LogProvider]) {
        LogService.providers = providers
    }
    
    static public func register(provider: LogProvider) {
        providers.append(provider)
    }
    
    private func log(_ logLevel: LogLevel, _ object: Any, filename: String, funcName: String, line: Int) {
        LogService.providers.forEach {
            $0.log(logLevel, message: ("\(object)"), file: LogService.fileName(filePath: filename), function: funcName, line: line)
        }
    }
    
    public func info(_ object: Any, filename: String = #file, funcName: String = #function, line: Int = #line) {
        self.log(.info, object, filename: filename, funcName: funcName, line: line)
    }
    
    public func debug(_ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        self.log(.debug, object, filename: filename, funcName: funcName, line: line)
    }
    
    public func verbose(_ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        self.log(.verbose, object, filename: filename, funcName: funcName, line: line)
    }
    
    public func warning(_ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        self.log(.warning, object, filename: filename, funcName: funcName, line: line)
    }
    
    public func error(_ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        self.log(.error, object, filename: filename, funcName: funcName, line: line)
    }
    
    public func activeProviders<T: LogProvider>(type: T.Type) -> [T] {
        
        var returnProviders: [T] = []
        
        LogService.providers.forEach { (provider) in
            
            var coreProvider: LogProvider = provider
            
            while let cp = coreProvider as? LogProviderWrapper {
                coreProvider = cp.wrapping
            }
            
            if let cp = coreProvider as? T {
                returnProviders.append(cp)
            }
        }
        
        return returnProviders
    }
    
    private static func fileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}
