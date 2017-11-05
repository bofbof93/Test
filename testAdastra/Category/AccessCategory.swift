//
//  AccessTodo.swift
//  testAdastra
//
//  Created by boufaied youssef on 03/11/2017.
//  Copyright © 2017 boufaied youssef. All rights reserved.
//
import UIKit
import Foundation
import CoreData

public class AccessCategory {
    var entityCategory = NSEntityDescription()
    func  getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
  
    init() {
        entityCategory = NSEntityDescription.entity(forEntityName: "Category", in: self.getContext())!
    }
    func getAllCategories()->[Category] {
        let context = self.getContext()
        let fetchRequest :NSFetchRequest<Category> = Category.fetchRequest()
        
       
      
        var listCategories : [Category] = [Category]()
        
        do {
            listCategories = try context.fetch(fetchRequest)
            
        } catch {
            print("Error with request: \(error)")
        }
        
        
        return listCategories
    }

   
    func addfirstCategories(){
        
        let entityCategory = NSEntityDescription.entity(forEntityName: "Category", in: self.getContext())
        let  categoryWork = NSManagedObject(entity: entityCategory!, insertInto: self.getContext())
        categoryWork.setValue("Work", forKey: "name")
        categoryWork.setValue("198,218,2", forKey: "color")
        let  categoryImportant = NSManagedObject(entity: entityCategory!, insertInto: self.getContext())
        categoryImportant.setValue("Important", forKey: "name")
        categoryImportant.setValue("245,82,45", forKey: "color")
        do {
            try self.getContext().save()
            print("saved category!")
            UserDefaults.standard.set(false,forKey:"FirstRun")
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
}

