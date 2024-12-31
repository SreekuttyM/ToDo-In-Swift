//
//  ToDoListTableViewCell.swift
//  ToDoList-Swift
//
//  Created by Sreekutty Maya on 31/12/2024.
//

import UIKit


class ToDoListTableViewCell : UITableViewCell {
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    
    static var tableCellIdentifier : String = "ToDoListTableViewCell"
}
