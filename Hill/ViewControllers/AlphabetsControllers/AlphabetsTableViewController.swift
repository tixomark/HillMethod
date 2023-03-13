//
//  AlphabetsTableViewController.swift
//  Hill
//
//  Created by Tixon Markin on 05.12.2019.
//  Copyright © 2019 Tixon Markin. All rights reserved.
//

import UIKit

class AlphabetsTableViewController: UITableViewController {
    
    @IBOutlet weak var editButtonOutlet: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editButtonOutlet.title = "Edit"
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HillController.shared.alphabets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlphabetCell", for: indexPath)
        configure(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    func configure(cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        cell.textLabel?.text = HillController.shared.alphabets[indexPath.row].name
        cell.detailTextLabel?.text = "Power: \(HillController.shared.alphabets[indexPath.row].letters.count)"
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            HillController.shared.alphabets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Button actions
    
    @IBAction func editButtonAction(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        editButtonOutlet.title = tableView.isEditing ? "Done" : "Edit"
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditAlphabet" {
            let addAlphabetViewController = segue.destination as! AddAlphabetViewController
            addAlphabetViewController.alphabet = HillController.shared.alphabets[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    @IBAction func unwindToAlphabetsTable(segue: UIStoryboardSegue) {
        
        guard segue.identifier == "SaveAlphabet",
            let addAlphabetViewController = segue.source as? AddAlphabetViewController,
            let alphabet = addAlphabetViewController.alphabet else { return }
        
        if let indexPath = tableView.indexPathForSelectedRow {
            HillController.shared.alphabets[indexPath.row] = alphabet
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: HillController.shared.alphabets.count, section: 0)
            HillController.shared.alphabets.append(alphabet)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
}
