//
//  LogProviderConformingToLogLevel.swift
//  TkTkKit
//
//  Created by Colm McMullan on 12/06/2020.
//  Copyright © 2020 Tiki-Taka Limited. All rights reserved.
//

import Foundation

struct LogProviderFilteringToMinimumLogLevel: LogProviderWrapper {
    
    var wrapping: LogProvider
    var minimumLogLevel: LogLevel
    
    init(wrapping: LogProvider, minimumLogLevel: LogLevel) {
        self.wrapping = wrapping
        self.minimumLogLevel = minimumLogLevel
    }
    
    func log(_ messageLogLevel: LogLevel, message: String, file: String, function: String, line: Int) {
        if messageLogLevel.rawValue >= minimumLogLevel.rawValue {
            wrapping.log(messageLogLevel, message: message, file: file, function: function, line: line)
        }
    }
}

extension LogProvider {
    func filterToLogLevel(minimumLogLevel: LogLevel) -> LogProvider {
        return LogProviderFilteringToMinimumLogLevel(wrapping: self,
                                                     minimumLogLevel: minimumLogLevel)
    }
}
