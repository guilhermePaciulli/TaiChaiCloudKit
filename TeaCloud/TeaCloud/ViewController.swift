//
//  ViewController.swift
//  TeaCloud
//
//  Created by João Gabriel Borelli Padilha on 03/10/17.
//  Copyright © 2017 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var teaName: UITextField!
    @IBOutlet weak var teaContents: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        teaName.delegate = self
        teaContents.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveTea(_ sender: Any) {
        let manager = CKManager.init()
        //let dataBase = CKContainer.default().privateCloudDatabase
        let alertaController = UIAlertController(title: "Salvar", message: "Deseja salvar o cha ?", preferredStyle: .alert)
        let acaoConfirmar = UIAlertAction(title: "Confirmar", style: .default) { (UIAlertAction) in
            if (self.teaName.text != "") && (self.teaContents.text != "") {
                let t = Tea(name: self.teaName.text!, contents: self.teaContents.text!)
                manager.save(t: t)
            }
        }
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertaController.addAction(acaoConfirmar)
        alertaController.addAction(acaoCancelar)
        // Apresentar alerta
        present(alertaController,animated:true,completion: nil)
    }
    
    // MARK: - TextField Methods
    
    func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === self.teaName {
            //self.closeKeyboard()
            //return false
            self.teaContents.becomeFirstResponder()
        }else if textField === self.teaContents{
            self.closeKeyboard()
            return false
        }
        //self.closeKeyboard() // TEMPORAREMANETE AQUI
        return false
    }
    
}

