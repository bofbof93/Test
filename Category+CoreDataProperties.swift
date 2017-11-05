//
//  Category+CoreDataProperties.swift
//  
//
//  Created by boufaied youssef on 05/11/2017.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var color: String?
    @NSManaged public var name: String?

}
