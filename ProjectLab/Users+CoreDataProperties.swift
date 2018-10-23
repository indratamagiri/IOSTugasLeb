//
//  Users+CoreDataProperties.swift
//  ProjectLab
//
//  Created by user on 15/05/18.
//  Copyright © 2018 user. All rights reserved.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var telp: String?

}
