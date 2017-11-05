//
//  ViewController.swift
//  testAdastra
//
//  Created by boufaied youssef on 02/11/2017.
//  Copyright © 2017 boufaied youssef. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import UserNotificationsUI
import PopupDialog
class AddTodoViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource{
    
    let requestIdentifier = "SampleRequest"
    
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var categoryPicker: UIPickerView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var headerView: UIView!
    @IBOutlet var nameTodo: UITextField!
    var objectID : NSManagedObjectID = NSManagedObjectID()
    var name : String = ""
    var category : String = ""
    var date : Date = Date()
    let accessCategory : AccessCategory = AccessCategory()
    let accessTodo : AccessTodo = AccessTodo()
    var listCategories : [Category] = [Category]()
    var fromEdit : Bool = false
   
   // var accessTodo : AccessTodo = AccessTodo()
    func  getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(fromEdit){
            deleteButton.isHidden = false
        }
     
        if(name != ""){
            self.nameTodo.text = name
        }
      
        
      
        

            self.datePicker.setDate(date, animated: true)
        
        
        self.view.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        nameTodo.becomeFirstResponder()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard))
        listCategories.removeAll()
        listCategories = self.accessCategory.getAllCategories()
        self.headerView.backgroundColor = Utils.parseColor(string: listCategories[0].color!)
        if(category != ""){
            if(self.searchForCategory(string: category) != -1){
                let index = self.searchForCategory(string: category)
                self.categoryPicker.selectRow(index, inComponent: 0, animated: true)
               
                self.headerView.backgroundColor = Utils.parseColor(string: listCategories[index].color!)
            }
        }
   
        self.categoryPicker.reloadAllComponents()
        //self.todo.category = listCategories[0]
       
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listCategories.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.listCategories[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let category = self.listCategories[row]
        let backgroundColor : UIColor = Utils.parseColor(string: category.color!)
        self.headerView.backgroundColor = backgroundColor
        //self.todo.category = category
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
 
    @IBAction func doneAction(_ sender: Any) {
       
        
        if(fromEdit){
            self.accessTodo.updateTodo(objectId: self.objectID, name: self.nameTodo.text!, date: self.datePicker.date, category: self.listCategories[self.categoryPicker.selectedRow(inComponent: 0)])
            self.navigationController?.popViewController(animated: true)
        }else{
            if(self.nameTodo.text != ""){
        let date = self.datePicker.date
        
        
        let calendar = Calendar.current
        
        let f = DateFormatter()
        
        
        let newTodo = Todo(entity: NSEntityDescription.entity(forEntityName: "Todo", in: self.getContext())!, insertInto: self.getContext())
        let day = f.shortWeekdaySymbols[calendar.component(.weekdayOrdinal, from: date)]
        let dayNumber = calendar.component(.day, from: date)
        let month = f.shortMonthSymbols[calendar.component(.month, from: date)-1]
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
      
        newTodo.date = " \(dayNumber) \(month)"
        newTodo.dateComplete = date
        
        newTodo.name = self.nameTodo.text!
        newTodo.time = "\(hour):\(minutes)"
        newTodo.category = self.listCategories[self.categoryPicker.selectedRow(inComponent: 0)]
        newTodo.isdeleted = "false"
       
        do {
            try self.getContext().save()
            print("saved Todo!")
            if(UserDefaults.standard.bool(forKey: "NotifEnabled")){
            triggerNotification(todo:newTodo)
            }
            self.navigationController?.popViewController(animated: true)
            
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        }else{
                let popup = PopupDialog(title: "Name empty !", message: "Please fill the name of the Todo")
                
                // Create buttons
                let buttonCancel = CancelButton(title: "Okay", action:{
                    self.dismiss(animated: true, completion: nil)
                })
                popup.addButton(buttonCancel)
                 self.present(popup, animated: true, completion: nil)
                
        }
        
      
        
    }
    }
    func triggerNotification(todo:Todo) {
        let content = UNMutableNotificationContent()
        content.title = "\(todo.name!) must be done"
        content.subtitle = "\((todo.category?.name)!)"
        content.body = "You must complete this task \(todo.name!)-\((todo.category?.name)!)"
        content.sound = UNNotificationSound.default()
        
        //To Present image in notification
      
        let components = Calendar.current.dateComponents([.weekday, .hour, .minute], from: self.datePicker.date)
        // Deliver the notification in five seconds.
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier:requestIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(request){(error) in
            
            if (error != nil){
                
                print(error?.localizedDescription as Any)
            }
        }
    }
    func searchForCategory(string:String) -> Int {
        var i = 0
        
        for category in listCategories {
            
            if(category.name == string){
                
                
                return i
            }
            i = i+1
        }
        return -1
    }
    @IBAction func deleteAction(_ sender: Any) {
        self.accessTodo.deleteTodo(objectId: objectID)
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension AddTodoViewController:UNUserNotificationCenterDelegate{
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    }
    
    //This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        if notification.request.identifier == requestIdentifier{
            
            completionHandler( [.alert,.sound,.badge])
            
        }
}
}

