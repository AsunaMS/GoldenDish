//
//  CoreDish+CoreDataProperties.swift
//  GoldenDish
//
//  Created by נדב אבנון on 21/02/2021.
//
//

import Foundation
import CoreData


extension CoreDish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDish> {
        return NSFetchRequest<CoreDish>(entityName: "CoreDish")
    }

    @NSManaged public var dishId: Int64

}

extension CoreDish : Identifiable {

}
