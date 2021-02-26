//
//  DishRecipe+CoreDataClass.swift
//  GoldenDish
//
//  Created by נדב אבנון on 21/02/2021.
//
//

import Foundation
import CoreData

@objc(CoreDishRecipe)
public class CoreDishRecipe: NSManagedObject {
 
    convenience init(dishId:Int64,title:String, readyInMinutes: Int64, imageUrl: String, glutenFree:Bool, vegan:Bool, vegetarian:Bool, veryHealthy:Bool, veryPopular:Bool,ingrediants:[String]) {
        self.init(context:CoreData.sharedContext)
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
    }
}
