//
//  TableController.swift
//  TableView
//
//  Created by Richard Richard on 8/31/17.
//  Copyright © 2017 Richard Richard. All rights reserved.
//

import UIKit

class TableController: Parent, UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in
        tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nim = arrayOfUsers[indexPath.row]["nim"] as? String ?? ""
        let name = arrayOfUsers[indexPath.row]["name"] as? String ?? ""
        let course = arrayOfUsers[indexPath.row]["course"] as? String ?? ""
        let score = arrayOfUsers[indexPath.row]["score"] as? String ?? ""
        let cell:UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "tableCell")
        cell.textLabel?.text = "Student \(indexPath.row)"
        cell.detailTextLabel?.text = ("\(nim) - \(name)    \(course) - \(score)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.deleteUser(idToDelete: self.arrayOfUsers[indexPath.row]["_id"] as! String)
        }
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            let updateView = self.storyboard?.instantiateViewController(withIdentifier: "updateDataView") as! UpdateViewController
            // Passing value between controller
            updateView.oldUser = self.arrayOfUsers[indexPath.row]
            self.navigationController?.pushViewController(updateView, animated: true)
        }
        return [delete, edit]
    }
}
