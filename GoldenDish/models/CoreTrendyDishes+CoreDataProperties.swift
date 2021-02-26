//
//  CoreTrendyDishes+CoreDataProperties.swift
//  GoldenDish
//
//  Created by נדב אבנון on 21/02/2021.
//
//

import Foundation
import CoreData


extension CoreTrendyDishes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreTrendyDishes> {
        return NSFetchRequest<CoreTrendyDishes>(entityName: "CoreTrendyDishes")
    }

    @NSManaged public var dishes: NSSet?

}

// MARK: Generated accessors for dishes
extension CoreTrendyDishes {

    @objc(addDishesObject:)
    @NSManaged public func addToDishes(_ value: CoreDish)

    @objc(removeDishesObject:)
    @NSManaged public func removeFromDishes(_ value: CoreDish)

    @objc(addDishes:)
    @NSManaged public func addToDishes(_ values: NSSet)

    @objc(removeDishes:)
    @NSManaged public func removeFromDishes(_ values: NSSet)

}

extension CoreTrendyDishes : Identifiable {

}
