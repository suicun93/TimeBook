//
//  Reminder+CoreDataProperties.swift
//  
//
//  Created by Hoang Duc on 7/31/19.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var hour: String?
    @NSManaged public var meditation: String?
    @NSManaged public var negative: String?
    @NSManaged public var positive: String?
    @NSManaged public var toDo: String?
    @NSManaged public var oneDay: OneDay?

}
