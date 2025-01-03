//
//  CoreDataManager.swift
//  ToDoList-Swift
//
//  Created by Sreekutty Maya on 31/12/2024.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    public static let modelName = "TodoList"

    private init() { } // Ensures singleton usage
    
    public static let model: NSManagedObjectModel = {
      // swiftlint:disable force_unwrapping
      let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
      return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: CoreDataManager.modelName, managedObjectModel: CoreDataManager.model) // Replace with your .xcdatamodeld file name
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
