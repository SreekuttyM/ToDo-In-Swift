//
//  Todo+CoreDataProperties.swift
//  ToDoList-Swift
//
//  Created by Sreekutty Maya on 31/12/2024.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var attachment: Data?
    @NSManaged public var category: String
    @NSManaged public var date: Date
    @NSManaged public var name: String
    @NSManaged public var title: String

}

extension Todo : Identifiable {

}
