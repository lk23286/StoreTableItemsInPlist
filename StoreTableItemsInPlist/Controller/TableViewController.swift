//
//  ViewController.swift
//  StoreTableItemsInPlist
//
//  Created by Laszlo Kovacs on 2023. 06. 19..
//

import UIKit

class TableViewController: UITableViewController {
    
    var itemArray = ["Apple", "Banan"]

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    

}

