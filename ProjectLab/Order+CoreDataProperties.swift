//
//  Order+CoreDataProperties.swift
//  ProjectLab
//
//  Created by user on 21/05/18.
//  Copyright © 2018 user. All rights reserved.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var date_order: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var size: String?
    @NSManaged public var pizzaName: String?
    @NSManaged public var price: Double
    @NSManaged public var qty: Int32
    @NSManaged public var toppingMoz: Bool
    @NSManaged public var toppingMush: Bool
    @NSManaged public var toppingPin: Bool
    @NSManaged public var toppingPap: Bool

}
