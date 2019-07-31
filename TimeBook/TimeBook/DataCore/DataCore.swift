//
//  DataCore.swift
//  TimeBook
//
//  Created by Hoang Duc on 7/30/19.
//  Copyright © 2019 Hoang Duc. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Supporter {
    func createData(list:[OneDay]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let oneDayEntity = NSEntityDescription.entity(forEntityName: "OneDay", in: managedContext)!
        
        for n in list {
            let oneDay = NSManagedObject(entity: oneDayEntity, insertInto: managedContext)
            oneDay.setValue(n.date, forKey: "date")
            
        }
    }
}
