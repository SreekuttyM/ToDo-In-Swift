//
//  ToDoList_SwiftTests.swift
//  ToDoList-SwiftTests
//
//  Created by Sreekutty Maya on 01/01/2025.
//

import XCTest
@testable import ToDoList_Swift

final class ToDoList_SwiftTests: XCTestCase {

    var sut: TodoListManager!

       override func setUp() {
           super.setUp()
           let coreDataStack = CoreDataTestManager()
           sut = TodoListManager(mainContext: coreDataStack.context)
       }

       override func tearDown() {
           sut = nil
           super.tearDown()
       }
    
   
    func test_listig() {
        let results = sut.fetchToDoList(category: "Home")
        XCTAssertEqual(results.count, 0)
    }
    
    func test_insertion() {
        sut.createTodoItem(title: "test22", name: "tiele2", date: Date(), category: "Work")
        let results = sut.fetchToDoList(category: "Work")
        XCTAssertEqual(results.last?.name, "tiele2")
        XCTAssertEqual(results.last?.title, "test22")
        XCTAssertEqual(results.last?.category, "Work")


    }

}
