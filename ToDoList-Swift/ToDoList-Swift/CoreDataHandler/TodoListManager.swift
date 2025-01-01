//
//  TodoListManager.swift
//  ToDoList-Swift
//
//  Created by Sreekutty Maya on 01/01/2025.
//

import CoreData


class TodoListManager {
    let mainContext: NSManagedObjectContext
  
    init(mainContext: NSManagedObjectContext = CoreDataManager.shared.context) {
          self.mainContext = mainContext
    }
    
    
    func fetchToDoList(category : String) -> [Todo] {
        let request = Todo.createFetchRequest()
        let context = CoreDataManager.shared.context
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
        let todo = Todo(context: self.mainContext)
        todo.title = todo.title
        todo.name = todo.name
        todo.date = Date()
        todo.category = todo.category
        todo.attachment = todo.attachment
        if self.mainContext.hasChanges {
            do {
                try self.mainContext.save()
                print("Saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
