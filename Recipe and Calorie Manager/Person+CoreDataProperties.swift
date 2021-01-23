//
//  Person+CoreDataProperties.swift
//  Recipe and Calorie Manager
//
//  Created by 鈴木ちほり on 2021/01/22.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var birthday: Date?
    @NSManaged public var gender: String?
    @NSManaged public var weight: Double
    @NSManaged public var height: Double
    @NSManaged public var activityType: String?

}

extension Person : Identifiable {

}
