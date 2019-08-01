//
//  OneDayViewController.swift
//  TimeBook
//
//  Created by Hoang Duc on 7/30/19.
//  Copyright © 2019 Hoang Duc. All rights reserved.
//

import UIKit
import CoreData

class OneDayViewController: UIViewController {
    
    var date:Date?
    var listMeditationByHour:[String] = []
    var listOneDay = [OneDay]()
    var listReminder = [Reminder]()
    var cells:[OneDayTableViewCell]!
    var oneDay:OneDay?
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var scrollView: UITableView!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        do {
            try insertOneDay()
            backButton(self)
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func getAllOneDayCell() -> [OneDayTableViewCell] {
        var list = cells!
        list.sort { (cell1, cell2) -> Bool in
            cell1.index < cell2.index
        }
        return list
    }
    
    func insertOneDay() throws {
        let oneDay = OneDay(context: self.context)
        oneDay.done = "done"
        oneDay.notDone = "notDone"
        oneDay.date = date
        for cell in getAllOneDayCell() {
                let reminder = Reminder(context: self.context)
                reminder.negative = cell.minusTxt.text
                reminder.positive = cell.plusText.text
                reminder.toDo = cell.toDoTxt.text
                reminder.indexxx = Double(cell.index)
                oneDay.addToListReminder(reminder)
        }
        self.context.insert(oneDay)
        try self.context.save()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cells = [OneDayTableViewCell]()
        listMeditationByHour = Config.loadListMeditationByHour()
        loadData()
    }
    
    func loadData() {
        for n in listOneDay {
            if n.date == date {
                oneDay = n
            }
        }
        listReminder = [Reminder]()
        if let reminder = oneDay?.listReminder {
            for player in reminder {
                listReminder.append(player as! Reminder)
            }
            listReminder.sort { (r1, r2) -> Bool in
                return r1.indexxx < r2.indexxx
            }
        }
    }
    
    
}

extension OneDayViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oneDayCell") as! OneDayTableViewCell
        cell.index = indexPath.row
        cell.hourTxt.text = Hour.allValues[indexPath.row].rawValue
        cell.meditationTxt.text = listMeditationByHour[indexPath.row]
        if listReminder.count > indexPath.row {
            cell.minusTxt.text = listReminder[indexPath.row].negative
            cell.plusText.text = listReminder[indexPath.row].positive
            cell.toDoTxt.text = listReminder[indexPath.row].toDo
        }
        if !cells.contains(cell) {
            cells.append(cell)
        }
        return cell
    }

}

// Supporter
extension OneDayViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let date = date {
            let dateFm = DateFormatter()
            dateFm.dateFormat = "dd-MM-yyyy"
            dateLbl.text = dateFm.string(from: date)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // Handle keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = 0
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
}
