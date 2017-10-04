//
//  CloudKitManager.swift
//  TaiChai
//
//  Created by Guilherme Paciulli on 03/10/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class CloudKitManager {
    
    static let shared = CloudKitManager()
    
    let container: CKContainer
    
    let database: CKDatabase
    
    let TeaType = "Tea"
    
    private init() {
        container = CKContainer.default()
        database = container.publicCloudDatabase
    }
    
    func save(tea: Tea) {
        let record = CKRecord(recordType: TeaType)
        record[.teaName] = tea.name
        
        database.save(record) { (record, error) in
            guard error == nil else {
                print("Error in saving registry")
                return
            }
            
            print("Sucess in saving the registry")
        }
    }
    
}
