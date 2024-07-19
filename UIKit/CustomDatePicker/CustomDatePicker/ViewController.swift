//
//  ViewController.swift
//  CustomDatePicker
//
//  Created by Chung Wussup on 5/22/24.
//

import UIKit

class ViewController: UIViewController {
    private lazy var datePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let years = [Int](2000...2150)
    let months = [Int](1...12)
    let days = [Int](1...31)
    var selectedMonth: Int = 1
    var selectedYear: Int = 1
    var selectedDay: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
}

extension ViewController: UIPickerViewDelegate {
    
}

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return years.count
        case 1:
            return months.count
        case 2:
            if selectedMonth == 2 {
                return ((selectedYear % 4 != 0) && (selectedYear % 100 == 0) && selectedYear % 400 == 0) ? 29 : 28
            } else if [4,6,9,11].contains(selectedMonth) {
                return 30
            } else {
                return days.count
            }
            
            
            
        default:
            return 0
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return years[row].description
        case 1:
            return months[row].description
        case 2:
            return days[row].description
        default:
            return nil
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedYear = years[row]
        case 1:
            selectedMonth = months[row]
        case 2:
            selectedDay = days[row]
        default:
            break
        }
        datePicker.reloadAllComponents()
    }
}
