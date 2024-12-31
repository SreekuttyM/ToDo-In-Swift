//
//  AddRemainderViewController.swift
//  ToDoList-Swift
//
//  Created by Sreekutty Maya on 31/12/2024.
//

import UIKit


class AddRemainderViewController : UIViewController, UNUserNotificationCenterDelegate {
   
    @IBOutlet weak var view_calender: UIView!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var view_stack: UIStackView!
    @IBOutlet weak var lbl_errorView: UILabel!
    var dateComponents : DateComponents?

    let timePicker : UIDatePicker = UIDatePicker()
    var isRepeat: Bool = false
    var viewModel : AddRemainderViewModel = AddRemainderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCalenderView()
    }
    
    
    func createCalenderView() {
        let calendarView = UICalendarView()
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.tintColor = .systemMint
        calendarView.availableDateRange = DateInterval(start: .now, end: .distantFuture)
        calendarView.translatesAutoresizingMaskIntoConstraints = false

        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
        view_calender .addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view_calender.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view_calender.trailingAnchor),
            calendarView.centerXAnchor.constraint(equalTo: view_calender.centerXAnchor)
        ])
    }
    
    func openTimePicker()  {
        timePicker.datePickerMode = UIDatePicker.Mode.time
        timePicker.frame = CGRect(x: self.view_stack.frame.width - 180, y: self.view_stack.frame.origin.y - 68, width: 200, height: 150.0)
        timePicker.backgroundColor = UIColor.white
        self.view.addSubview(timePicker)
        timePicker.addTarget(self, action: #selector(self.startTimeDiveChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func startTimeDiveChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        lbl_time.text = formatter.string(from: sender.date)
        timePicker.removeFromSuperview() 
        lbl_errorView.text = ""
    }
    
    @IBAction func btnAction_setTime(_ sender: Any) {
        openTimePicker()
    }
    
    @IBAction func btnAction_isRepeat(_ sender: UISwitch) {
        isRepeat = sender.isOn
    }
    
    @IBAction func btnAction_save(_ sender: Any) {
        lbl_errorView.text = ""
        if let dateComponents = dateComponents, let time = lbl_time.text {
            let timeDate = viewModel.createDate(dateComponents: dateComponents, time: time)
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: ["date":timeDate])
            self.navigationController?.popViewController(animated: false)
        } else {
            lbl_errorView.text = "Please select date or time"
        }
    }
    
}


extension AddRemainderViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        self.dateComponents = dateComponents
        lbl_errorView.text = ""
    }
}
