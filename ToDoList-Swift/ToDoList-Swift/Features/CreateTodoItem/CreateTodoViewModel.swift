//
//  CreateTodoViewModel.swift
//  ToDoList-Swift
//
//  Created by Sreekutty Maya on 31/12/2024.
//
import Foundation
import Combine

@available(iOS 15, *)
struct CreateTodoItemState {
    var title: String = ""
    var name: String = ""
    var date: Date = Date.now
    var category: String = ""
    var attachment : Data? = nil
    var isEnteredDetailsValid: Bool = false
}

@available(iOS 15, *)
class CreateTodoViewModel  {
    @Published var title: String = ""
    @Published var name: String = ""
    @Published var category: String = ""
    @Published var attachment : Data? = nil
    @Published var state : CreateTodoItemState = CreateTodoItemState()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupValidation()
    }
     
    
    private func setupValidation() {
        // Combine all publishers
        Publishers.CombineLatest4($title, $name,$category,$attachment)
            .map { title, name, category,attachment in
                return CreateTodoItemState(title: title,name: name,category: category,attachment: attachment,isEnteredDetailsValid: !title.isEmpty &&  !category.isEmpty &&  !name.isEmpty)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
    }

    func configure(todo : Todo) {
        todo.title = state.title
        todo.name = state.name
        todo.date = Date()
        todo.category = state.category
        todo.attachment = state.attachment
    }
}
