//
//  CoreDataManager.swift
//  ToDoList-Swift
//
//  Created by Sreekutty Maya on 31/12/2024.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
        
    private init() { } // Ensures singleton usage
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TodoList") // Replace with your .xcdatamodeld file name
        container.persistentStoreDescriptions.forEach { storeDesc in
                  storeDesc.shouldMigrateStoreAutomatically = true
                  storeDesc.shouldInferMappingModelAutomatically = true
              }
        container.loadPersistentStores { storeDescription, error in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = self.context
        if context.hasChanges {
            do {
                try context.save()
                print("Saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
   
    
    

}
