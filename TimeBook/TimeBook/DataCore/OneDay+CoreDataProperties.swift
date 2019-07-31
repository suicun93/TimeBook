//
//  OneDay+CoreDataProperties.swift
//  
//
//  Created by Hoang Duc on 7/31/19.
//
//

import Foundation
import CoreData


extension OneDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OneDay> {
        return NSFetchRequest<OneDay>(entityName: "OneDay")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var done: String?
    @NSManaged public var meditationCoffee: Bool
    @NSManaged public var meditationTime: Int32
    @NSManaged public var notDone: String?
    @NSManaged public var listReminder: NSSet?

}

// MARK: Generated accessors for listReminder
extension OneDay {

    @objc(addListReminderObject:)
    @NSManaged public func addToListReminder(_ value: Reminder)

    @objc(removeListReminderObject:)
    @NSManaged public func removeFromListReminder(_ value: Reminder)

    @objc(addListReminder:)
    @NSManaged public func addToListReminder(_ values: NSSet)

    @objc(removeListReminder:)
    @NSManaged public func removeFromListReminder(_ values: NSSet)

}
