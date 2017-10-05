//
//  NewTeaViewController.swift
//  TeaCloud
//
//  Created by Guilherme Paciulli on 04/10/17.
//  Copyright © 2017 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class TeaViewController: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var teaNameTextField: UITextField!
    
    @IBOutlet weak var teaContentTextField: UITextField!
    
    @IBOutlet weak var shareTea: UISwitch!
    
    var personalTeasTableViewController: PersonalTeasTableViewController?
    
    var tea: Tea?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popUpView.layer.cornerRadius = 15
        self.popUpView.clipsToBounds = true
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tea = self.tea {
            self.titleLabel.text = tea.name
            self.teaContentTextField.text = tea.contents
            self.titleLabel.text = "Edit Tea"
            //Need to add here to get if the tea was shared
        } else {
            self.titleLabel.text = "New Tea"
        }
    }
    
    @IBAction func didSavedTea(_ sender: Any) {
        if let teaName = self.teaNameTextField.text, let teaContent = self.teaContentTextField.text {
            let shareTea = self.shareTea.isOn
            if !teaName.isValid() || !teaContent.isValid() {
                self.popUpView.shake()
                return
            }
            if let _ = tea {
            } else {
                let t = Tea(name: teaName, contents: teaContent)
                CKManager.shared.save(t: t, privado: !shareTea)
            }
        } else {
            self.popUpView.shake()
        }
        self.dismiss(animated: true)
        personalTeasTableViewController?.loadData()
    }
    
    @IBAction func didCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
