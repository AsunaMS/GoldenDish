//
//  CoreData.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 03/02/2021.
//

import CoreData
class CoreData {
    
    // shared referece for our CoreData static object
    public static let shared:CoreData = CoreData()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GoldenDish")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
      //  container.viewContext.mergePolicy = NSMergePolicyType.
        return container
    }()
    
    
    func deleteAllTrendy() {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "CoreDishRecipe")
        guard let people = try? context.fetch(request)else{return}
        
        for person in people {
            context.delete(person)
        }
        saveContext()
        
    }
    
    func deleteAllHot() {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "CoreHotRecipe")
        guard let people = try? context.fetch(request)else{return}
        
        for person in people {
            context.delete(person)
        }
        saveContext()
    }
   
    
    func getUser()-> CoreUser{
        let context = persistentContainer.viewContext
        //1) fetch request
        let request: NSFetchRequest<CoreUser> = CoreUser.fetchRequest()
        
        //2) execute:
        var pool:CoreUser?
        if let users = try? context.fetch(request){
            if users.count > 0 {
                pool = users[0]
            }
        }
        if let pool = pool  {
            return pool
        } else  {
            let newUser = CoreUser()
            saveContext()
            return newUser
        }
    }
    

    func saveCoreDishRecipe(recipe:CoreDishRecipe) {
        print("saved")
        // saveContext()
    }
    func saveCoreHotRecipe(recipe:CoreHotRecipe) {
        print("saved")
        // saveContext()
    }
    
    // save the whole core data context
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    private init() {}
}
