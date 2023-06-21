//
//  ViewController.swift
//  StoreTableItemsInPlist
//
//  Created by Laszlo Kovacs on 2023. 06. 19..
//

import UIKit

class TableViewController: UITableViewController {
    
   var itemArray = [Item]()
    
    //["Apple", "Banan"]
    
    //var defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.appendingPathComponent("item.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)
        
        let item = Item()
        item.title = "Apple"
        itemArray.append(item)
        
//        if let items = defaults.array(forKey: "TodoItems") as? [String] {
//            itemArray = items
//        }
      
    }

    //MARK: - Table
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell")
        
        let item = itemArray[indexPath.row]
        
        cell?.textLabel?.text = item.title
        
        cell?.accessoryType = item.done ? .checkmark: .none
        
        return cell!
        
    }
    
    //MARK: - Checkmark
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.deselectRow(at: indexPath, animated: true)
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        saveItems()
        
    }
    //MARK: - Add Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { alert in
            
            if let newTextField = textField.text {
                
                let newItem = Item()
                newItem.title = newTextField
                self.itemArray.append(newItem)
            }
           
            self.saveItems()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { alertTextField in
            textField = alertTextField
        }
        
        present(alert, animated: true)
    }
    
    //MARK: - Data Manipulation
   
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
                  
        } catch {
            print(error)
        }
        tableView.reloadData()
        
    }
    
    
}

