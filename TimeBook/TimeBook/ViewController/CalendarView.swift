//
//  SecondViewController.swift
//  TimeBook
//
//  Created by Hoang Duc on 7/26/19.
//  Copyright © 2019 Hoang Duc. All rights reserved.
//

import UIKit
import FSCalendar
import CoreData

class CalendarView: UIViewController {

    var listOneDay = [OneDay]()
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OneDayViewController {
            let date = sender as! Date
            destination.date = date
            destination.listOneDay = listOneDay
        }
    }
    
    func refresh() {
        let request = OneDay.fetchRequest() as NSFetchRequest<OneDay>
        do {
            listOneDay = try context.fetch(request)
        } catch let error as NSError {
            print("Can not fetch with error \(error)")
        }
    }
}
extension CalendarView: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        performSegue(withIdentifier: "showOneDay", sender: date)
    }
}
