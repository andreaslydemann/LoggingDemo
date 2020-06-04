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
    
    // MARK: - Logging methods
    
    /// Logs info messages on console with prefix [ℹ️]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    func info( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {

            LogService.providers.forEach {
                $0.log(.info, msg: ("\(object)"), file: LogService.sourceFileName(filePath: filename), function: funcName, line: line)
            }
    }
    
    /// Logs debug messages on console with prefix [📝]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    func debug( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {

                        LogService.providers.forEach {
                            $0.log(.debug, msg: ("\(object)"), file: LogService.sourceFileName(filePath: filename), function: funcName, line: line)
            }
        
    }
    
    /// Logs messages verbosely on console with prefix [📣]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    func verbose( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {

                        LogService.providers.forEach {
                            $0.log(.verbose, msg: ("\(object)"), file: LogService.sourceFileName(filePath: filename), function: funcName, line: line)
            }
    }
    
    /// Logs warnings verbosely on console with prefix [⚠️]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    func warning( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {

            LogService.providers.forEach {
                $0.log(.warning, msg: ("\(object)"), file: LogService.sourceFileName(filePath: filename), function: funcName, line: line)
            }
        
    }
    
    /// Logs error messages on console with prefix [☠️]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    func error( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {

            LogService.providers.forEach {
                $0.log(.error, msg: ("\(object)"), file: LogService.sourceFileName(filePath: filename), function: funcName, line: line)
            }
    }
    
    /// Extract the file name from the file path
    ///
    /// - Parameter filePath: Full file path in bundle
    /// - Returns: File Name with extension
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}
