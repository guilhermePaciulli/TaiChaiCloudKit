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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    func loadData() {
        CKManager.shared.fetchTea(callback: ({ (teas, error) in
            if let successfull = teas {
                self.personalTeas = successfull
            }
        }))
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.personalTeas.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "personalTeaCell", for: indexPath)
        if let teaCell = cell as? PersonalTeaTableViewCell {
            teaCell.tea = self.personalTeas[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
