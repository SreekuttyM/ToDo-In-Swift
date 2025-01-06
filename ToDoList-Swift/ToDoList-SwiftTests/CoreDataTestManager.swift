//
//  CoreDataTestManager.swift
//  ToDoList-SwiftTests
//
//  Created by Sreekutty Maya on 02/01/2025.
//

import Foundation
import CoreData
@testable import ToDoList_Swift


class CoreDataTestManager : CoreDataManager {
    override init() {
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: CoreDataTestManager.modelName, managedObjectModel: CoreDataTestManager.model) // Replace with your .xcdatamodeld file name
        container.persistentStoreDescriptions.forEach { storeDesc in
            storeDesc.shouldMigrateStoreAutomatically = true
            storeDesc.shouldInferMappingModelAutomatically = true
        }
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { storeDescription, error in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        persistentContainer = container
    }
}
