//
//  CoreUser+CoreDataClass.swift
//  GoldenDish
//
//  Created by נדב אבנון on 23/02/2021.
//
//

import Foundation
import CoreData

@objc(CoreUser)
public class CoreUser: NSManagedObject {
    convenience init() {
        self.init(context:CoreData.shared.persistentContainer.viewContext)
        self.coreDishRecipes = []
        self.coreHotRecipes = []
        self.favoriteHotRecipes = []
        self.favoriteDishRecipes = []
    }
    
    func insertFavoriteDishRecipe(recipe:CoreDishRecipe) {
        let cRecipe = CoreDishFavoriteRecipe.init(dishId: recipe.dishId, title: recipe.title ?? "", readyInMinutes: recipe.readyInMinutes, imageUrl: recipe.imageUrl ?? "", glutenFree: recipe.glutenFree, vegan: recipe.vegan, vegetarian: recipe.vegetarian, veryHealthy: recipe.veryHealthy, veryPopular: recipe.veryPopular, ingrediants: recipe.ingrediants ?? [], instructions: recipe.instructions ?? "")
        guard let recipes = self.favoriteDishRecipes else {return}
        var rArray = recipes.allObjects
        rArray.append(cRecipe)
        let nsArray = NSSet(array: rArray)
        self.favoriteDishRecipes = nsArray
        
        CoreData.shared.saveContext()
    }
    
    func insertFavoriteHotRecipe(recipe:CoreHotRecipe) {
        let cRecipe = CoreHotFavoriteRecipe.init(dishId: recipe.dishId, title: recipe.title ?? "", readyInMinutes: recipe.readyInMinutes, imageUrl: recipe.imageUrl ?? "", glutenFree: recipe.glutenFree, vegan: recipe.vegan, vegetarian: recipe.vegetarian, veryHealthy: recipe.veryHealthy, veryPopular: recipe.veryPopular, ingrediants: recipe.ingrediants ?? [], instructions: recipe.instructions ?? "")
        guard let recipes = self.favoriteHotRecipes else {return}
        var rArray = recipes.allObjects
        rArray.append(cRecipe)
        let nsArray = NSSet(array: rArray)
        self.favoriteHotRecipes = nsArray
        CoreData.shared.saveContext()
    }
    func removeFavoriteDishRecipe(recipe:CoreDishFavoriteRecipe) {
        
        guard let recipes = self.favoriteDishRecipes else {return}
        var rArray:Array<CoreDishFavoriteRecipe> = recipes.allObjects as! Array<CoreDishFavoriteRecipe>
        rArray.removeAll { (recipex) -> Bool in
            recipe.title == recipex.title
        }
        let nsArray = NSSet(array: rArray)
        self.favoriteDishRecipes = nsArray
        CoreData.shared.saveContext()
    }
    
    func removeFavoriteHotRecipe(recipe:CoreHotFavoriteRecipe) {
        guard let recipes = self.favoriteHotRecipes else {return}
        var rArray:Array<CoreHotFavoriteRecipe> = recipes.allObjects as! Array<CoreHotFavoriteRecipe>
        rArray.removeAll { (recipex) -> Bool in
            recipe.title == recipex.title
        }
        let nsArray = NSSet(array: rArray)
        self.favoriteHotRecipes = nsArray
        CoreData.shared.saveContext()
    }
    
    func insertDishRecipe(recipe:CoreDishRecipe) {
        guard let recipes = self.coreDishRecipes else {return}
        var rArray = recipes.allObjects
        rArray.append(recipe)
        let nsArray = NSSet(array: rArray)
        print(nsArray.count)
        self.coreDishRecipes = nsArray
    }
    
    func resetRecipes() {
        let dishRecipes:[CoreDishRecipe] = []
        let hotRecipes:[CoreDishRecipe] = []
        let nsArray = NSSet(array: dishRecipes)
        let nsArray2 = NSSet(array: hotRecipes)
        self.coreDishRecipes = nsArray
        self.coreHotRecipes = nsArray2
        CoreData.shared.saveContext()
    }
    
    func setLastLoaded(date:Date) {
        self.lastLoad = date
        CoreData.shared.saveContext()
    }
    
    func insertHotRecipe(recipe:CoreHotRecipe) {
        guard let recipes = self.coreHotRecipes else {return}
        var rArray = recipes.allObjects
        rArray.append(recipe)
        let nsArray = NSSet(array: rArray)
        self.coreHotRecipes = nsArray
    }
}
