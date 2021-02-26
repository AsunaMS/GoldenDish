//
//  DishRecipe+CoreDataProperties.swift
//  GoldenDish
//
//  Created by נדב אבנון on 21/02/2021.
//
//

import Foundation
import CoreData


extension CoreDishRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDishRecipe> {
        return NSFetchRequest<CoreDishRecipe>(entityName: "CoreDishRecipe")
    }

    @NSManaged public var dishId: Int64
    @NSManaged public var title: String?
    @NSManaged public var readyInMinutes: Int64
    @NSManaged public var imageUrl: String?
    @NSManaged public var ingrediants: [String]?
    @NSManaged public var glutenFree: Bool
    @NSManaged public var vegan: Bool
    @NSManaged public var vegetarian: Bool
    @NSManaged public var veryHealthy: Bool
    @NSManaged public var veryPopular: Bool

}

extension CoreDishRecipe : Identifiable {

}
