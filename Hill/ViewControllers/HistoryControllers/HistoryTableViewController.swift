//
//  HistoryTableViewController.swift
//  Hill
//
//  Created by Tixon Markin on 03.12.2019.
//  Copyright © 2019 Tixon Markin. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    @IBOutlet weak var editButtonOutlet: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editButtonOutlet.title = "Edit"
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: HillController.historyUpdatedNotification, object: nil)
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func reloadTableView() {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HillController.shared.hillItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(cell: HistoryCell, forItemAt indexPath: IndexPath) {
        let hillItem = HillController.shared.hillItems[indexPath.row]
        cell.matrixDimensionLabel.text = String(describing: hillItem.matrix!.count)
        cell.keyTextLabel.text = hillItem.text.lowercased()
        cell.alphabetNameLabel.text = "\(hillItem.alphabet.name) alphabet"
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 88
//    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            HillController.shared.hillItems.remove(at: indexPath.row)
        }
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        editButtonOutlet.title = tableView.isEditing ? "Done" : "Edit"
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailHistoryItem" {
            let detailHillItemViewController = segue.destination as! DetailHillItemViewController
            detailHillItemViewController.hillItem = HillController.shared.hillItems[tableView.indexPathForSelectedRow!.row]
        }
    }
    
}
