//
//  ViewController.swift
//  Todo List
//
//  Created by Jonathan Burnett on 29/12/2020.
//

import UIKit

class TodoListViewController: UITableViewController, AddItemViewConrollerDelegate {
  
    func addItemViewControllerDidCancel(_ controller: AddItemViewConroller) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewConroller, didFinishEditing item: TodoListItem) {
         
        if let index = items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
         navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewConroller, didFinishingAdding item: TodoListItem) {
       
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        let newRowIndex = items.count
        let item = TodoListItem()
        
        
        var titles = ["Hello 1", "Hello2", "Hello3", "Hello4", "hello5",]
        let randomNumber = arc4random_uniform(UInt32(titles.count))
        let title = titles[Int(randomNumber)]
        item.text = title
        
        item.checked = true
        
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
    }
    
    var items:[TodoListItem]
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [TodoListItem]()
        
        let row0Item = TodoListItem()
        row0Item.text = "Walk the Dog"
        row0Item.checked = false
        items.append(row0Item)
        
        let row1Item = TodoListItem()
        row1Item.text = "Brush my hair"
        row1Item.checked = false
        items.append(row1Item)
        
        let row2Item = TodoListItem()
        row2Item.text = "Learn iOS Development"
        row2Item.checked = false
        items.append(row2Item)
        
        let row3Item = TodoListItem()
        row3Item.text = "Football training"
        row3Item.checked = false
        items.append(row3Item)
        
        let row4Item = TodoListItem()
        row4Item.text = "Eat ice cream"
        row4Item.checked = false
        items.append(row4Item)
        
        let row5Item = TodoListItem()
        row5Item.text = "Go to bed"
        row5Item.checked = false
        items.append(row5Item)
        
        let row6Item = TodoListItem()
        row6Item.text = "Play Nintendo Switch"
        row6Item.checked = false
        items.append(row6Item)
        
        let row7Item = TodoListItem()
        row7Item.text = "Go to work"
        row7Item.checked = false
        items.append(row7Item)
        
        super.init(coder: aDecoder)
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Additem" {
            let controller = segue.destination as! AddItemViewConroller
            controller.delegate = self
        } else if segue.identifier ==  "EditItem" {
            let controller = segue.destination as! AddItemViewConroller
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = items[indexPath.row]
            item.toggleChecked()
           
            configureCheckedMark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todolistitem", for: indexPath)
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckedMark(for: cell, with: item)
        return cell
    }
    
    func configureText(for cell: UITableViewCell, with item: TodoListItem) {
        let label = cell.viewWithTag(1000)as! UILabel
        label.text = item.text
    }
    
    func configureCheckedMark(for cell: UITableViewCell, with item: TodoListItem) {
        
        let label = cell.viewWithTag(1001)  as! UILabel
        
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    
 //END
}


