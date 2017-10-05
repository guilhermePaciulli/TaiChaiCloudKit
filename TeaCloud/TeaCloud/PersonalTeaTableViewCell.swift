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
    
    @IBOutlet weak var sharedTeaSwitch: UISwitch!
    
    var tea: Tea?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let tea = self.tea {
            teaNameLabel.text = tea.name
            teaContentLabel.text = tea.contents
            self.sharedTeaSwitch.isOn = CKManager.shared.existsOnPublic(t: tea)
        }
    }
    
    @IBAction func didChangePrivacy(_ sender: UISwitch) {
        if(sender.isOn){
            let record = CKRecord.init(recordType: "Tea", recordID: CKRecordID(recordName: (tea?.id)!))
            record[.name] = tea?.name
            record[.contents] = tea?.contents
            CKManager.shared.savePublic(record: record)
            
        } else {
            if let id = tea?.id {
                CKManager.shared.deleteTea(id: id, privado: false)
            }
        }
    }
}
