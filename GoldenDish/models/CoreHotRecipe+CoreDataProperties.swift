//
//  CoreHotRecipe+CoreDataProperties.swift
//  GoldenDish
//
//  Created by נדב אבנון on 22/02/2021.
//
//

import Foundation
import CoreData


extension CoreHotRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreHotRecipe> {
        return NSFetchRequest<CoreHotRecipe>(entityName: "CoreHotRecipe")
    }

    @NSManaged public var dishId: Int64
    @NSManaged public var glutenFree: Bool
    @NSManaged public var imageUrl: String?
    @NSManaged public var ingrediants: NSArray?
    @NSManaged public var readyInMinutes: Int64
    @NSManaged public var title: String?
    @NSManaged public var instructions: String?
    @NSManaged public var vegan: Bool
    @NSManaged public var vegetarian: Bool
    @NSManaged public var veryHealthy: Bool
    @NSManaged public var veryPopular: Bool

}

extension CoreHotRecipe : Identifiable {

}
