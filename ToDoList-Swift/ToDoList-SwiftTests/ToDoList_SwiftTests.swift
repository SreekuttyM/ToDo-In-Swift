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
           sut = TodoListManager(coreDataManager: coreDataStack)
       }

       override func tearDown() {
           sut = nil
           super.tearDown()
       }
    
   
    func test_listig() {
        let results = sut.fetchToDoList(category: "Home")
        XCTAssertEqual(results.count, 0)
    }
    
    func test_insertOneItem() {
        sut.createTodoItem(title: "tes3", name: "tiee23", date: Date(), category: "Home")
        let results = sut.fetchToDoList(category: "Home")
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.last?.name, "tiee23")
        XCTAssertEqual(results.last?.title, "tes3")
        XCTAssertEqual(results.last?.category, "Home")
    }
    
    func test_insert2Items() {
        sut.createTodoItem(title: "test111", name: "test1", date: Date(), category: "Home")
        sut.createTodoItem(title: "tes3", name: "tiee23", date: Date(), category: "Home")
        let results = sut.fetchToDoList(category: "Home")
        XCTAssertEqual(results.count, 2)

    }

}
