//
//  ViewController.swift
//  TeaCloud
//
//  Created by João Gabriel Borelli Padilha on 03/10/17.
//  Copyright © 2017 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveTea(_ sender: Any) {
//        let dataBase = CKContainer.default().privateCloudDatabase
        let alertaController = UIAlertController(title: "Salvar", message: "Deseja salvar o cha ?", preferredStyle: .alert)
        let acaoConfirmar = UIAlertAction(title: "Confirmar", style: .default) { (UIAlertAction) in
            //
        }
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertaController.addAction(acaoConfirmar)
        alertaController.addAction(acaoCancelar)
        // Apresentar alerta
        present(alertaController,animated:true,completion: nil)
    }
    
}

