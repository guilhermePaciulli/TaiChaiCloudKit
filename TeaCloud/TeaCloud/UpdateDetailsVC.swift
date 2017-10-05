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
        teaName.text = tea.name
        teaContents.text = tea.contents
        teaShared.isOn = CKManager.shared.existsOnPublic(t: tea)
    }
    
    @IBAction func deleteCurrentTea(_ sender: Any) {
        if CKManager.shared.existsOnPublic(t: tea) {
            CKManager.shared.deleteTea(id: tea.id, privado: false)
        }
        CKManager.shared.deleteTea(id: tea.id, privado: true)
    }
    
    @IBAction func edit(_ sender: Any) {
        let newTea = Tea.init(name: self.teaName.text!, contents: self.teaContents.text!, id: self.tea.id)
        CKManager.shared.updateTea(t: newTea, privado: true)
        self.navigationController?.popViewController(animated: true)
    }

}
