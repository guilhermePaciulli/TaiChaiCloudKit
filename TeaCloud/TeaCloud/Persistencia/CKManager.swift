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
        
        privateDB.save(record) { (r, error) in
            guard error == nil else {
                print("Problema ao tentar salvar o registro")
                return
            }
            print("Registro salvo com sucesso")
        }
        
        if !privado {
            self.publicDB.save(record) { (record, error) in
                guard error == nil else {
                    print("Problema ao tentar salvar o registro")
                    return
                }
                print("silvao salvo")
                print("Registro salvo com sucesso")
            }
        }
    }
    
    func saveWithId(t: Tea, privado: Bool) {
        //let record = CKRecord(recordType: TeaType)
        let record = CKRecord.init(recordType: TeaType, recordID: CKRecordID.init(recordName: t.id))
        record[.name] = t.name
        record[.contents] = t.contents
        
        privateDB.save(record) { (r, error) in
            guard error == nil else {
                print("Problema ao tentar salvar o registro")
                return
            }
            print("Registro salvo com sucesso")
        }
        
        if !privado {
            self.publicDB.save(record) { (record, error) in
                guard error == nil else {
                    print("Problema ao tentar salvar o registro")
                    return
                }
                print("silvao salvo")
                print("Registro salvo com sucesso")
            }
        }
    }
    
    func savePublic (record: CKRecord){
        publicDB.save(record) { (record, error) in
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
                return Tea(name: name, contents: contents,id: record.recordID.recordName)
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
    
    func deleteTea(id:String , privado : Bool) {
        var db = publicDB
        if privado {
            db = privateDB
        }
        
        let selectedRecordID = CKRecordID(recordName: id)
        db.delete(withRecordID: selectedRecordID) { (recordID, error) in
            if error != nil {
                print(error)
            }else {
                print("DELETOU")
            }
        }
        
    }
    
    func updateTea(t: Tea, privado:Bool) {
        let predicate =  NSPredicate(value: true)
        let query = CKQuery(recordType: TeaType, predicate: predicate)
        
        var db = publicDB
        
        if privado {
            db = privateDB
        }
        
        db.perform(query, inZoneWith: nil) { (records, error) in
            guard error == nil else {
                print("ERROR A")
                return
            }
            
            guard let teaRecords = records else {
                print("ERROR B")
                return
            }
            
            let teas = teaRecords.map({ (record) in
                var identificador:String = ""
                if String(describing: record.recordID) == t.id {
                    // Guarda o identificador
                    identificador = String(describing: record.recordID)
                    // Deleta o antigo
                    self.deleteTea(id: identificador, privado: privado)
                    // Adiciona o novo com o identificador
                    self.saveWithId(t: t, privado: privado)
                }
            })
            
        }
    }
    
    func existsOnPublic(t: Tea) -> Bool {
        var sit:Bool = false
        let predicate =  NSPredicate(value: true)
        let query = CKQuery(recordType: TeaType, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            guard error == nil else {
                print("ERROR A")
                return
            }
            
            guard let teaRecords = records else {
                print("ERROR B")
                return
            }
            
            let teas = teaRecords.map({ (record) in
                if String(describing: record.recordID) == t.id {
                    sit = true
                }
            })
        }
        return sit
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
        }
    }
}
