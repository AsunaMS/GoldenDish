//
//  CoreUser+CoreDataProperties.swift
//  GoldenDish
//
//  Created by נדב אבנון on 23/02/2021.
//
//

import Foundation
import CoreData


extension CoreUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreUser> {
        return NSFetchRequest<CoreUser>(entityName: "CoreUser")
    }

    @NSManaged public var coreDishRecipes: NSSet?
    @NSManaged public var coreHotRecipes: NSSet?
    @NSManaged public var favoriteDishRecipes: NSSet?
    @NSManaged public var favoriteHotRecipes: NSSet?
    @NSManaged public var lastLoad: Date?
}

// MARK: Generated accessors for coreDishRecipes
extension CoreUser {

    @objc(addCoreDishRecipesObject:)
    @NSManaged public func addToCoreDishRecipes(_ value: CoreDishRecipe)

    @objc(removeCoreDishRecipesObject:)
    @NSManaged public func removeFromCoreDishRecipes(_ value: CoreDishRecipe)

    @objc(addCoreDishRecipes:)
    @NSManaged public func addToCoreDishRecipes(_ values: NSSet)

    @objc(removeCoreDishRecipes:)
    @NSManaged public func removeFromCoreDishRecipes(_ values: NSSet)

}

// MARK: Generated accessors for coreHotRecipes
extension CoreUser {

    @objc(addCoreHotRecipesObject:)
    @NSManaged public func addToCoreHotRecipes(_ value: CoreHotRecipe)

    @objc(removeCoreHotRecipesObject:)
    @NSManaged public func removeFromCoreHotRecipes(_ value: CoreHotRecipe)

    @objc(addCoreHotRecipes:)
    @NSManaged public func addToCoreHotRecipes(_ values: NSSet)

    @objc(removeCoreHotRecipes:)
    @NSManaged public func removeFromCoreHotRecipes(_ values: NSSet)

}

extension CoreUser : Identifiable {

}
