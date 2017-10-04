//
//  PersonalTeaTableViewCell.swift
//  TeaCloud
//
//  Created by Guilherme Paciulli on 04/10/17.
//  Copyright © 2017 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit
import CloudKit

class PersonalTeaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teaNameLabel: UILabel!
    
    @IBOutlet weak var teaContentLabel: UILabel!
    
    var tea: Tea?
//    var tea: Tea? {
//        get {
//            return tea
//        }
//        set(newValue) {
//            if let value = newValue {
//                self.teaNameLabel.text = value.name
//                self.teaContentLabel.text = value.contents
//            }
//        }
//    }
    
    override func awakeFromNib() {
        teaNameLabel.text = tea?.name
        teaContentLabel.text = tea?.contents
    }
    
    @IBAction func didChangePrivacy(_ sender: UISwitch) {
        if(sender.isOn){
            //fica ativo de verdade
            print("oi1")
            print(tea?.id)
            let record = CKRecord.init(recordType: "Tea", recordID: CKRecordID(recordName: (tea?.id)!))
            record[.name] = tea?.name
            record[.contents] = tea?.contents
            CKManager.shared.savePublic(record: record)
           
        }else{
            //nao fica ativo
            print("oi2")
            if let id = tea?.id {
                 CKManager.shared.deleteTea(id: id, privado: false)
            }
        }
    }
}
