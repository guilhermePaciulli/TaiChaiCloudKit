//
//  PersonalTeasTableViewController.swift
//  TeaCloud
//
//  Created by Guilherme Paciulli on 04/10/17.
//  Copyright © 2017 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class PersonalTeasTableViewController: UITableViewController {
    
    var personalTeas: [Tea] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    func loadData() {
        CKManager.shared.fetchTea(privado: true, callback: ({ (teas, error) in
            if let successfull = teas {
                self.personalTeas = successfull
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.personalTeas.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.tableView.isEditing {
            let selectedTea = self.personalTeas[indexPath.row]
            self.showTeaViewController(toEdit: selectedTea)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "personalTeaCell", for: indexPath)
        if let teaCell = cell as? PersonalTeaTableViewCell {
            teaCell.tea = self.personalTeas[indexPath.row]
        }
        cell.awakeFromNib()
        cell.tag = indexPath.row
        return cell
    }
    
    @IBAction func newTea(_ sender: UIBarButtonItem) {
        self.showTeaViewController(toEdit: nil)
    }
    
    private func showTeaViewController(toEdit tea: Tea?) {
        if let storyboard = self.storyboard {
            if let teaViewController = storyboard.instantiateViewController(withIdentifier: "teaViewController") as? TeaViewController {
                if let tea = tea {
                    teaViewController.tea = tea
                }
                teaViewController.personalTeasTableViewController = self
                self.present(teaViewController, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "update" {
            
            let viewControllerDestino = segue.destination as! UpdateDetailsVC
            
            let celula = sender as! UITableViewCell
            print("Selecionada - \(celula.tag) - \(self.personalTeas[celula.tag].name)")
            viewControllerDestino.tea = self.personalTeas[celula.tag]
        }
    }
    
}
