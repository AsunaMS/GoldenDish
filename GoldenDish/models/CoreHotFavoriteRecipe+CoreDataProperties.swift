//
//  CoreHotFavoriteRecipe+CoreDataProperties.swift
//  GoldenDish
//
//  Created by נדב אבנון on 24/02/2021.
//
//

import Foundation
import CoreData


extension CoreHotFavoriteRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreHotFavoriteRecipe> {
        return NSFetchRequest<CoreHotFavoriteRecipe>(entityName: "CoreHotFavoriteRecipe")
    }
    
    @NSManaged public var rand: Int64
    @NSManaged public var dishId: Int64
    @NSManaged public var glutenFree: Bool
    @NSManaged public var imageUrl: String?
    @NSManaged public var ingrediants: NSArray?
    @NSManaged public var instructions: String?
    @NSManaged public var readyInMinutes: Int64
    @NSManaged public var title: String?
    @NSManaged public var vegan: Bool
    @NSManaged public var vegetarian: Bool
    @NSManaged public var veryHealthy: Bool
    @NSManaged public var veryPopular: Bool

}

extension CoreHotFavoriteRecipe : Identifiable {

}
