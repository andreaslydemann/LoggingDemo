//
//  LogProviderConformingToLogLevel.swift
//  TkTkKit
//
//  Created by Colm McMullan on 12/06/2020.
//  Copyright © 2020 Tiki-Taka Limited. All rights reserved.
//

import Foundation

struct LogLevelConformingToLogLevel: LogProviderWrapper {
    
    var wrapping: LogProvider
    
    var logLevel: LogLevel {
        return wrapping.logLevel
    }
    
    init(wrapping: LogProvider) {
        self.wrapping = wrapping
    }
    
    func log(_ event: LogEvent, message: String, file: String, function: String, line: Int) {
        if event.logLevel.rawValue >= logLevel.rawValue {
            wrapping.log(event, message: message, file: file, function: function, line: line)
        }
    }
}

extension LogProvider {
    func conformingToLogLevels() -> LogProvider {
        return LogLevelConformingToLogLevel(wrapping: self)
    }
}
