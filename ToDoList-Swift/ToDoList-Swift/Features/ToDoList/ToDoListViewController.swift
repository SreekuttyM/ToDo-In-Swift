//
//  ToDoListViewController.swift
//  ToDoList-Swift
//
//  Created by Sreekutty Maya on 31/12/2024.
//

import UIKit

class ToDoListViewController : UIViewController {
    
    @IBOutlet weak var tbleView_toDoValues: UITableView!
    var array_toDo : [Todo] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchToDoList(category: "Work")
    }
    
    
    
    func fetchToDoList(category : String) {
        let request = Todo.createFetchRequest()
        let context = CoreDataManager.shared.context
        request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "category contains[c] %@", category)
        request.predicate = predicate
        do {
            array_toDo = try context.fetch(request)
            print(array_toDo)
            DispatchQueue.main.async { [unowned self] in
                tbleView_toDoValues.reloadData()
            }
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
   
    @IBAction func segmentControl_category(_ sender: UISegmentedControl) {
        var category = "Work"
        switch(sender.selectedSegmentIndex) {
            case  0:
                category = "Work"
                break
            case 1:
                category = "Home"
                break
            case 2 :
                category = "Birthday"
                break
            default: break
                
        }
        self.fetchToDoList(category: category)
        
    }
    
    
}

extension ToDoListViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array_toDo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListTableViewCell.tableCellIdentifier, for: indexPath) as? ToDoListTableViewCell  else {
            fatalError("Could not dequeue cell with identifier: \(ToDoListTableViewCell.tableCellIdentifier)")
        }
        let todoItem : Todo = array_toDo[indexPath.row] as Todo
        cell.lbl_name.text = todoItem.name
        cell.lbl_title.text = todoItem.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
