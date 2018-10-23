//
//  userOrder.swift
//  ProjectLab
//
//  Created by user on 20/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import CoreData

class userOrder{
    var orders = [NSManagedObject]()
}

class UserBuy{
    var date_order: NSDate?
    var name: String?
    var pizzaName: String?
}
