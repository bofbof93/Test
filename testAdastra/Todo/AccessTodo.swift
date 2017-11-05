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

public class AccessTodo {
    var entityTodo = NSEntityDescription()
    func  getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    init() {
        entityTodo = NSEntityDescription.entity(forEntityName: "Todo", in: self.getContext())!
    }
    func getAllTodos()->[Todo] {
        let context = self.getContext()
        var listTodos : [Todo] = [Todo]()
       
        listTodos.removeAll()
        let fetchRequest:NSFetchRequest<Todo> = Todo.fetchRequest()
            do {
                listTodos = try context.fetch(fetchRequest)
                print ("num of results = \(listTodos.count)")
            
              
           
        }catch {
            print(error)
        }
      
       
        
           // fetchRequest.entity = entityTodo
            // var  menu = NSManagedObject(entity: entity!, insertInto: context)
            
        
        
        return listTodos
    }
    func deleteTodo(todo:Todo) {
        self.getContext().delete(todo)
       
        do {
            try self.getContext().save()
            print("saved category!")
            
            
        } catch let error as NSError  {
            print(error)
        }
        
    }
    func deleteTodo(objectId:NSManagedObjectID){
        do {let todo : Todo = try self.getContext().existingObject(with: objectId) as! Todo
            
            self.getContext().delete(todo)
        }catch let error as NSError{
            print("Could not find object \(error), \(error.userInfo)")
        }
        
    }
    func updateTodo(objectId:NSManagedObjectID,name:String,date:Date,category:Category) {
        
  
       
        do {let todo : Todo = try self.getContext().existingObject(with: objectId) as! Todo
           
            
            
            let calendar = Calendar.current
            
            let f = DateFormatter()
            
            
            let day = f.shortWeekdaySymbols[calendar.component(.weekdayOrdinal, from: date)]
            let dayNumber = calendar.component(.day, from: date)
            let month = f.shortMonthSymbols[calendar.component(.month, from: date)-1]
            
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            print("hours = \(hour):\(minutes):\(day)")
            todo.date = " \(dayNumber) \(month)"
            todo.dateComplete = date
            
            todo.name = name
            todo.time = "\(hour):\(minutes)"
            todo.category = category
            todo.isdeleted = "false"
            do {
                try self.getContext().save()
                print("updated Todo!")
                
                
                
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        } catch let error as NSError{
            print("Could not find object \(error), \(error.userInfo)")
        }
 
  
}
}
