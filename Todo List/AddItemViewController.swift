//
//  AddItemViewController.swift
//  Todo List
//
//  Created by Jonathan Burnett on 29/12/2020.
//

import UIKit

protocol AddItemViewConrollerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewConroller)
    func addItemViewController(_ controller: AddItemViewConroller, didFinishingAdding item: TodoListItem)
    func addItemViewController(_ controller: AddItemViewConroller, didFinishEditing item: TodoListItem)
}

class AddItemViewConroller: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    var itemToEdit: TodoListItem?
    
    weak var delegate: AddItemViewConrollerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        
        if let itemToEdit = itemToEdit {
            itemToEdit.text = textField.text!
            delegate?.addItemViewController(self, didFinishEditing: itemToEdit)
        } else {
        
        let item = TodoListItem()
        item.text = textField.text!
        item.checked = false
        delegate?.addItemViewController(self, didFinishingAdding: item)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
        
        return true
    }

}
