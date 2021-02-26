//
//  CoreDishRecipe+CoreDataClass.swift
//  GoldenDish
//
//  Created by נדב אבנון on 22/02/2021.
//
//

import Foundation
import CoreData

@objc(CoreDishFavoriteRecipe)
public class CoreDishFavoriteRecipe: NSManagedObject {
    convenience init(dishId:Int64,title:String, readyInMinutes: Int64, imageUrl: String, glutenFree:Bool, vegan:Bool, vegetarian:Bool, veryHealthy:Bool, veryPopular:Bool,ingrediants:NSArray,instructions:String) {
        self.init(context:CoreData.shared.persistentContainer.viewContext)
        self.dishId = dishId
        self.title = title
        self.readyInMinutes = readyInMinutes
        self.imageUrl = imageUrl
        self.glutenFree = glutenFree
        self.vegan = vegan
        self.vegetarian = vegetarian
        self.veryHealthy = veryHealthy
        self.veryPopular = veryPopular
        self.ingrediants = ingrediants
        self.instructions = instructions
        self.rand = Int64.random(in: 1..<9000000)
    }
}
