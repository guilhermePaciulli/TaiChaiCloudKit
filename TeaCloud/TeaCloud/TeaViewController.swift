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
    
    var tea: Tea?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popUpView.layer.cornerRadius = 15
        self.popUpView.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tea = self.tea {
            self.titleLabel.text = tea.name
            self.teaContentTextField.text = tea.contents
            self.titleLabel.text = "Edit Tea"
        } else {
            self.titleLabel.text = "New Tea"
        }
    }

}
