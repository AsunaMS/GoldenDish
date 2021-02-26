//
//  CoreDish+CoreDataClass.swift
//  GoldenDish
//
//  Created by נדב אבנון on 21/02/2021.
//
//

import Foundation
import CoreData

@objc(CoreDish)
public class CoreDish: NSManagedObject {
    convenience init(dishId:Int64) {
        self.init(context:CoreData.sharedContext)
        self.dishId = dishId
    }
}
