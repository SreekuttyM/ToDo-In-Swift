//
//  CreateToDoItemViewController.swift
//  ToDoList-Swift
//
//  Created by Sreekutty Maya on 31/12/2024.
//

import UIKit
import Combine

class CreateToDoItemViewController : UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var txtField_title: UITextField!
    @IBOutlet weak var txtField_textView: UITextView!
    @IBOutlet weak var lbl_errorView: UILabel!
    let todoListManager : TodoListManager = TodoListManager()

    var viewModel : CreateTodoViewModel! = CreateTodoViewModel()
    private var cancellables = Set<AnyCancellable>()
    var  remainderDate : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBind()
        
    }
    
    func viewBind() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.setRemainderDate(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        lbl_errorView.text = ""
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
        lbl_errorView.text = ""
        if(viewModel.state.isEnteredDetailsValid) {
            todoListManager.createTodoItem(title: viewModel.state.title, name: viewModel.state.name, date: viewModel.state.date, category: viewModel.state.category)
            if let date = remainderDate {
                scheduleNotification(at: date, body:txtField_textView.text, titles: txtField_title.text ?? "")
            }
        } else {
            lbl_errorView.text = "validation failed"
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
    
    
    func scheduleNotification(at date: Date, body: String, titles:String) {
            let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute,.second,], from: date)

            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)

            let content = UNMutableNotificationContent()
            content.title = titles
            content.body = body
            content.sound = UNNotificationSound.default
            content.categoryIdentifier = "todoList"

            let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)

            //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().add(request) {(error) in
                if let error = error {
                    print("Uh oh! We had an error: \(error)")
                } else {
                    print("local notification added :\(date)")
                    DispatchQueue.main.async { [unowned self] in
                        self.navigationController?.popViewController(animated: false)
                    }
                }
            }
        }
    
    @objc func setRemainderDate(notification:NSNotification) {
        remainderDate = notification.userInfo?["date"] as? Date
        
    }
    
    

    
    
   
}



extension CreateToDoItemViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == txtField_title) {
            txtField_textView.becomeFirstResponder()
        }
    }
}
