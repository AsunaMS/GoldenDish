//
//  CoreTrendyDishes+CoreDataClass.swift
//  GoldenDish
//
//  Created by נדב אבנון on 21/02/2021.
//
//

import Foundation
import CoreData

@objc(CoreTrendyDishes)
public class CoreTrendyDishes: NSManagedObject {
    convenience init(dishes:NSSet) {
        self.init(context:CoreData.sharedContext)
        self.dishes = dishes
    }
}
