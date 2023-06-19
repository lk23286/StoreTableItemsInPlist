//
//  ViewController.swift
//  StoreTableItemsInPlist
//
//  Created by Laszlo Kovacs on 2023. 06. 19..
//

import UIKit

class TableViewController: UITableViewController {
    
    var itemArray = ["Apple", "Banan"]
    
    var defaults = UserDefaults()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoItems") as? [String] {
            itemArray = items
        }
        // Do any additional setup after loading the view.
    }

    //MARK: - Table
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell")
        
        cell?.textLabel?.text = itemArray[indexPath.row]
        
        return cell!
        
    }
    
    //MARK: - Checkmark
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    //MARK: - Add Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { alert in
            
            if let newItem = textField.text {
                self.itemArray.append(newItem)
                
                self.defaults.set(self.itemArray, forKey: "TodoItems")
            }
           
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { alertTextField in
            textField = alertTextField
        }
        
        present(alert, animated: true)
    }
    
}

