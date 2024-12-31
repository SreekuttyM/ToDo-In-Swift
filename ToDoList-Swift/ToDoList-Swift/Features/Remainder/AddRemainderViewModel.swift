//
//  AddRemainderViewModel.swift
//  ToDoList-Swift
//
//  Created by Sreekutty Maya on 31/12/2024.
//

import Foundation


class AddRemainderViewModel {
    func createDate(dateComponents:DateComponents ,time :String) -> Date {
        let date = dateComponents.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let formatteddateString = formatter.string(from: date!)
        let dateString = formatteddateString + " " + time
        formatter.dateFormat = "yyyy/MM/dd hh:mm a"
        let time = formatter.date(from:dateString) ?? Date()
        return time
    }
}
