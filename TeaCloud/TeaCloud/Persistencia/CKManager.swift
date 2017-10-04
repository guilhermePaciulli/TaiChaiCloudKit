//
//  CKManager.swift
//  TeaCloud
//
//  Created by João Gabriel Borelli Padilha on 03/10/17.
//  Copyright © 2017 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit
import CloudKit
import UserNotifications

class CKManager {
    static let shared = CKManager()
    
    let container: CKContainer
    let publicDB: CKDatabase
    let privateDB: CKDatabase
    
    let TeaType = "Tea"
    
    // MARK: - Initializers
    init() {
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
    
    func save(t: Tea, privado: Bool) {
        let record = CKRecord(recordType: TeaType)
        record[.name] = t.name
        record[.contents] = t.contents
        
        var db = publicDB
        
        if privado {
            db = privateDB
        }
        
        db.save(record) { (record, error) in
            guard error == nil else {
                print("Problema ao tentar salvar o registro")
                return
            }
            
            print("Registro salvo com sucesso")
        }
    }
    
    func fetchTea(privado: Bool, callback: @escaping ([Tea]?, Error?)->Void) {
        
        let predicate =  NSPredicate(value: true)
        
        let query = CKQuery(recordType: TeaType, predicate: predicate)
        
        var db = publicDB
        
        if privado {
            db = privateDB
        }
        
        db.perform(query, inZoneWith: nil) { (records, error) in
            guard error == nil else {
                print("ERROR A")
                callback(nil, error)
                return
            }
            
            guard let teaRecords = records else {
                print("ERROR B")
                let e = NSError(domain: "", code: 500, userInfo: nil)
                callback(nil, e)
                return
            }
            
            let teas = teaRecords.map({ (record) -> Tea in
                let name = record.value(forKey: "name") as? String ?? ""
                let contents = record.value(forKey: "contents") as? String ?? ""
                
                return Tea(name: name, contents: contents)
            })
            
            callback(teas, nil)
        }
    }
    
    func startObservingChanges() {
        
        if let sid = UserDefaults.standard.value(forKey: "subscriptionID") as? String {
            print("Notificação já registrada \(sid)")
            //            return
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (authorized, error) in
            guard error == nil, authorized else {
                return
            }
            
            self.getNotificationSettings()
            
            let subscription = CKQuerySubscription(recordType: self.TeaType, predicate: NSPredicate(value: true), options: [.firesOnRecordCreation])
            
            let info = CKNotificationInfo()
            info.alertLocalizationKey = "mackstudents_updated_alert"
            info.alertLocalizationArgs = ["name"]
            info.soundName = "default"
            info.desiredKeys = ["name"]
            subscription.notificationInfo = info
            
            self.publicDB.save(subscription, completionHandler: { (savedSubscription, error) in
                guard let savedSubscription = savedSubscription, error == nil else {
                    print("Problema na Subscription \(error!)")
                    return
                }
                
                UserDefaults.standard.set(savedSubscription.subscriptionID, forKey: "subscriptionID")
            })
        }
    }
    
    func deleteTea(id:String) {
        
        let selectedRecordID = CKRecordID(recordName: id)
    
        publicDB.delete(withRecordID: selectedRecordID) { (recordID, error) in
            if error != nil {
                print(error)
            }else {
//                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                    //self.arrNotes.removeAtIndex(indexPath.row)
//                    //self.tblNotes.reloadData()
//                })
                print("DELETOU")
            }
        }
        
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
        }
    }
}
