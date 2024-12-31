//
//  CreateToDoItemViewController.swift
//  ToDoList-Swift
//
//  Created by Sreekutty Maya on 31/12/2024.
//

import UIKit
import Combine

class CreateToDoItemViewController : UIViewController {
    
    @IBOutlet weak var txtField_title: UITextField!
    @IBOutlet weak var txtField_textView: UITextView!
    
    var viewModel : CreateTodoViewModel! = CreateTodoViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewBind()
        
    }
    
    func viewBind() {
        txtField_title.textPublisher()
                    .receive(on: RunLoop.main)
                    .assign(to: \.title, on: viewModel)
                    .store(in: &cancellables)
        
        txtField_textView.textViewPublisher()
                    .receive(on: RunLoop.main)
                    .assign(to: \.name, on: viewModel)
                    .store(in: &cancellables)
        
    }
    
    @IBAction func btnAction_addAttchment(_ sender: Any) {
        
    }
    
    @IBAction func btnAction_save(_ sender: Any) {
        if(viewModel.state.isEnteredDetailsValid) {
            let todo = Todo(context:  CoreDataManager.shared.context)
            viewModel.configure(todo: todo)
            CoreDataManager.shared.saveContext()
        } else {
            print("validation failed")
        }
    }
    
    @IBAction func btnAction_setRemainder(_ sender: Any) {
        
    }
    
    
    @IBAction func chooseCategory(_ sender: Any) {
        let ac = UIAlertController(title: "Choose", message: nil, preferredStyle: .actionSheet)

        ac.addAction(UIAlertAction(title: "Work", style: .default) { [unowned self] _ in
            viewModel.category = "Work"
        })
        ac.addAction(UIAlertAction(title: "Home", style: .default) { [unowned self] _ in
            viewModel.category = "Home"

        })

        ac.addAction(UIAlertAction(title: "Birthday", style: .default) { [unowned self] _ in
            viewModel.category = "Birthday"

        })
        

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
   
}



extension CreateToDoItemViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == txtField_title) {
            txtField_textView.becomeFirstResponder()
        }
    }
}
