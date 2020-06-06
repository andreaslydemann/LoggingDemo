//
//  LogDateFormatter.swift
//  TodoApp
//
//  Created by Andreas Lüdemann on 06/06/2020.
//  Copyright © 2020 Andreas Lüdemann. All rights reserved.
//

import Foundation

final public class LogDateFormatter: DateFormatter {
    public static var dateFormat = "yyyy-MM-dd HH:mm:ssSSS"
    
    public convenience init(dateFormat: String = dateFormat) {
        self.init()
        self.dateFormat = dateFormat
        self.locale = Locale.current
        self.timeZone = TimeZone.current
    }
}

internal extension DateFormatter {
    func getCurrentDateAsString() -> String {
        self.string(from: Date())
    }
}
