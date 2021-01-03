//
//  TodoListItem.swift
//  Todo List
//
//  Created by Jonathan Burnett on 29/12/2020.
//

import Foundation

class TodoListItem: NSObject {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
}
