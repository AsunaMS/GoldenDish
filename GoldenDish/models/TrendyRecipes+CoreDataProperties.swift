//
//  TrendyRecipes+CoreDataProperties.swift
//  GoldenDish
//
//  Created by נדב אבנון on 21/02/2021.
//
//

import Foundation
import CoreData


extension TrendyRecipes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrendyRecipes> {
        return NSFetchRequest<TrendyRecipes>(entityName: "TrendyRecipes")
    }

    @NSManaged public var recipes: NSSet?

}

// MARK: Generated accessors for recipes
extension TrendyRecipes {

    @objc(addRecipesObject:)
    @NSManaged public func addToRecipes(_ value: CoreDishRecipe)

    @objc(removeRecipesObject:)
    @NSManaged public func removeFromRecipes(_ value: CoreDishRecipe)

    @objc(addRecipes:)
    @NSManaged public func addToRecipes(_ values: NSSet)

    @objc(removeRecipes:)
    @NSManaged public func removeFromRecipes(_ values: NSSet)

}

extension TrendyRecipes : Identifiable {

}
