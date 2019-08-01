//
//  Reminder+CoreDataProperties.swift
//  
//
//  Created by Hoang Duc on 8/1/19.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var negative: String?
    @NSManaged public var positive: String?
    @NSManaged public var toDo: String?
    @NSManaged public var indexxx: Double
    @NSManaged public var oneDay: OneDay?

}
