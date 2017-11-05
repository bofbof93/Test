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
        
       // fetchRequest = Category.fetchRequest()
      
        var listCategories : [Category] = [Category]()
        
        do {
            listCategories = try context.fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            print ("num of results categories = \(listCategories.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
          
            
        } catch {
            print("Error with request: \(error)")
        }
        
        
        return listCategories
    }
    func addTodo(todo:Todo)->Bool {
        
        let entityTodo = NSEntityDescription.entity(forEntityName: "Todo", in: self.getContext())
        let  todoObject = NSManagedObject(entity: entityTodo!, insertInto: self.getContext())
        todoObject.setValue(todo.name!, forKey: "name")
        todoObject.setValue(todo.category, forKey: "category")
        todoObject.setValue(todo.date, forKey: "date")
        todoObject.setValue(todo.time, forKey: "time")
        todoObject.setValue(todo.isdeleted, forKey: "isdeleted")
        
        do {
            try self.getContext().save()
            print("saved category!")
            
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        return false
    }
    func getTodo(objectId:NSManagedObjectID) -> Todo {
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>()
        let entityTodo = NSEntityDescription.entity(forEntityName: "Todo", in: self.getContext())
        var me = NSManagedObject()
        fetchRequest.entity = entityTodo
        let predicate:NSPredicate = NSPredicate(format: "(objectID = %@)", objectId)
        fetchRequest.predicate = predicate
        let todo : Todo = Todo()
        // var  menu = NSManagedObject(entity: entity!, insertInto: context)
        
        do {
            me = (try context.fetch(fetchRequest).first)!
            
            //I like to check the size of the returned results!
            //print ("num of results = \(todos.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            
            //get the Key Value pairs (although there may be a better way to do that...
            print("getme")
            
            
            todo.name = (me.value(forKey: "name") as! String)
            print(me.value(forKey: "name") as! String)
            
            
            
            
        } catch {
            print("Error with request: \(error)")
        }
        return todo
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

