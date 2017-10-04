//
//  CKRecordExtension.swift
//  TaiChai
//
//  Created by Guilherme Paciulli on 03/10/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import CloudKit

extension CKRecord {
    
    subscript(key: EntityField) -> Any? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue as? CKRecordValue
        }
    }
    
}
