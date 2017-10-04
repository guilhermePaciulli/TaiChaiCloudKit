//
//  Tea.swift
//  TeaCloud
//
//  Created by João Gabriel Borelli Padilha on 03/10/17.
//  Copyright © 2017 João Gabriel Borelli Padilha. All rights reserved.
//

import Foundation

enum TeaKey: String {
    case name
    case contents
}

struct Tea {
    let name: String
    let contents: String
    
    func string() -> String {
        return "\(name) - \(contents)"
    }
}
