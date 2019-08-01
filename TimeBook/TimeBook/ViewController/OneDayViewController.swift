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
    var oneDay:OneDay?
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var scrollView: UITableView!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let entity = NSEntityDescription.entity(forEntityName: "OneDay",in: context)!
        let oneDay = NSManagedObject(entity: entity,insertInto: context)
        oneDay.setValue(date, forKey: "date")
        do {
            try context.save()
            backButton(self)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
//    func saveData(oneDay:NSManagedObject)
//    {
//        oneDay.setValue("RDC", forKey: "username")
//        oneDay.setValue("1234", forKey: "password")
//        oneDay.setValue("21", forKey: "age")
//
//        print("Storing Data..")
//        do {
//            try context.save()
//        } catch {
//            print("Storing data Failed")
//        }
//    }
//
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listMeditationByHour = Config.loadListMeditationByHour()
        loadData()
    }
    
    func loadData() {
        for n in listOneDay {
            if n.date == date {
                oneDay = n
            }
        }
    }
    
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

extension OneDayViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oneDayCell") as! OneDayTableViewCell
        cell.hourTxt.text = Hour.allValues[indexPath.row].rawValue
        cell.meditationTxt.text = listMeditationByHour[indexPath.row]
        if let oneDay = oneDay {
            let dateFm = DateFormatter()
            dateFm.dateFormat = "dd-MM-yyyy"
            cell.minusTxt.text = dateFm.string(from: oneDay.date!)
        }
        
//        if let reminder = listReminder {
//            if reminder.count > indexPath.row {
//                cell.minusTxt.text = reminder[indexPath.row].negative
//                cell.plusText.text = reminder[indexPath.row].positive
//                cell.toDoTxt.text = reminder[indexPath.row].toDo
//            }
//        }
        return cell
    }
    

}
