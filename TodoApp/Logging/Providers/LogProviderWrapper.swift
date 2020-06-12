//
//  LogProviderWrapper.swift
//  TkTkKit
//
//  Created by Colm McMullan on 12/06/2020.
//  Copyright © 2020 Tiki-Taka Limited. All rights reserved.
//

import Foundation

protocol LogProviderWrapper: LogProvider {
    var wrapping: LogProvider { get }
}
