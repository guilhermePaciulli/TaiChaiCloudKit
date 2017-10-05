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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        teaName.text = tea.name
        teaContents.text = tea.contents
        teaShared.isOn = CKManager.shared.existsOnPublic(t: tea)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteCurrentTea(_ sender: Any) {
        CKManager.shared.deleteTea(id: tea.id, privado: true)
    }
    
    @IBAction func edit(_ sender: Any) {
        let newTea = Tea.init(name: self.teaName.text!, contents: self.teaContents.text!, id: self.tea.id)
        CKManager.shared.updateTea(t: newTea, privado: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
