//
//  Idea+CoreDataProperties.swift
//  pachira
//
//  Created by okumura reo on 2018/06/22.
//  Copyright © 2018年 reo. All rights reserved.
//
//

import Foundation
import CoreData


extension Idea {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Idea> {
        return NSFetchRequest<Idea>(entityName: "Idea")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var memo: String?
    @NSManaged public var pic1: Int16
    @NSManaged public var pic2: Int16
    @NSManaged public var updated_at: NSDate?
    @NSManaged public var created_at: NSDate?

}
