//
//  UpdateDetailsVC.swift
//  TeaCloud
//
//  Created by João Gabriel Borelli Padilha on 04/10/17.
//  Copyright © 2017 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class UpdateDetailsVC: UIViewController {
    
    var tea:Tea!

    @IBOutlet weak var teaName: UITextField!
    
    @IBOutlet weak var teaContents: UITextField!
    
    @IBOutlet weak var teaShared: UISwitch!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.teaShared.isEnabled = false
        teaName.text = tea.name
        teaContents.text = tea.contents
        CKManager.shared.existsOnPublic(t: tea, callback: ({ (exists) in
            DispatchQueue.main.async {
                if exists {
                    if !self.teaShared.isOn {
                        self.teaShared.setOn(true, animated: true)
                    }
                }
                self.teaShared.isEnabled = true
            }
        }))
    }
    
    @IBAction func deleteCurrentTea(_ sender: Any) {
        CKManager.shared.existsOnPublic(t: tea, callback: ({ (exists) in
            if exists {
                CKManager.shared.deleteTea(id: self.tea.id, privado: false)
            }
        }))
        CKManager.shared.deleteTea(id: tea.id, privado: true)
    }
    
    @IBAction func edit(_ sender: Any) {
        let newTea = Tea.init(name: self.teaName.text!, contents: self.teaContents.text!, id: self.tea.id)
        CKManager.shared.updateTea(t: newTea, privado: true)
        self.navigationController?.popViewController(animated: true)
    }

}
