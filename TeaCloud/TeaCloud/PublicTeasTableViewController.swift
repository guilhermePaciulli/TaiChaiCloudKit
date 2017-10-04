//
//  PublicTeasTableViewController.swift
//  TeaCloud
//
//  Created by Guilherme Paciulli on 04/10/17.
//  Copyright © 2017 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class PublicTeasTableViewController: UITableViewController {
    
    var publicTeas: [Tea] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    func loadData() {
        CKManager.shared.fetchTea(privado: false, callback: ({(teas, error) in
            if let successfull = teas {
                self.publicTeas = successfull
            }
        }))
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.publicTeas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "publicTeasCell", for: indexPath)
        let tea = self.publicTeas[indexPath.row]
        cell.textLabel?.text = tea.name
        cell.detailTextLabel?.text = tea.contents
        return cell
    }

}
