//
//  PersonalTeaTableViewCell.swift
//  TeaCloud
//
//  Created by Guilherme Paciulli on 04/10/17.
//  Copyright © 2017 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class PersonalTeaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teaNameLabel: UILabel!
    
    @IBOutlet weak var teaContentLabel: UILabel!
    
    var tea: Tea? {
        get {
            return self.tea
        }
        set(newValue) {
            if let value = newValue {
                self.teaNameLabel.text = value.name
                self.teaContentLabel.text = value.contents
            }
        }
    }
    
    @IBAction func didChangePrivacy(_ sender: UISwitch) {
    }
}
