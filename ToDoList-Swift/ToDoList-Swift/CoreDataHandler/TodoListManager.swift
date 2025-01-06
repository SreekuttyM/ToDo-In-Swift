//
//  TodoListManager.swift
//  ToDoList-Swift
//
//  Created by Sreekutty Maya on 01/01/2025.
//

import CoreData


class TodoListManager {
    let coreDataManager: CoreDataManager
  
    init(coreDataManager : CoreDataManager) {
          self.coreDataManager = coreDataManager
    }
    
    
    func fetchToDoList(category : String) -> [Todo] {
        let request = Todo.createFetchRequest()
        let context = coreDataManager.context
        request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "category contains[c] %@", category)
        request.predicate = predicate
        do {
            return try context.fetch(request)
            
        } catch {
            print("Failed to fetch data: \(error)")
        }
        
        return []
    }
    
    
    func createTodoItem(title:String,attachment:Data? = nil,name:String,date:Date,category:String) {
        let todo = Todo(context: coreDataManager.context)
        todo.title = title
        todo.name = name
        todo.date = Date()
        todo.category = category
        todo.attachment = attachment
        if coreDataManager.context.hasChanges {
            do {
                try coreDataManager.context.save()
                print("Saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
