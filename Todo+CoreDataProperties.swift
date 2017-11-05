//
//  Todo+CoreDataProperties.swift
//  
//
//  Created by boufaied youssef on 05/11/2017.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var date: String?
    @NSManaged public var dateComplete: NSDate?
    @NSManaged public var isdeleted: String?
    @NSManaged public var name: String?
    @NSManaged public var time: String?
    @NSManaged public var category: Category?

}
