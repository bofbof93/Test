 //
//  TodoTableViewController.swift
//  testAdastra
//
//  Created by boufaied youssef on 02/11/2017.
//  Copyright © 2017 boufaied youssef. All rights reserved.
//

import UIKit
import FoldingCell
import CoreData
import PopupDialog
import UserNotifications
class TodoTableViewController: UITableViewController {
    let requestIdentifier = "SampleRequest"
    @IBOutlet var buttonAdd: UIBarButtonItem!
    @IBOutlet var popupMenu: UIView!
    let kCloseCellHeight: CGFloat = 135
    let kOpenCellHeight: CGFloat = 312
    let kRowsCount = 100
    var cellHeights: [CGFloat] = []
    var listTodo : [Todo] = [Todo]()
    var listTodoDeleted : [Todo] = [Todo]()
    let accessTodo : AccessTodo = AccessTodo()
    let accessCategory : AccessCategory = AccessCategory()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        let vc = UIStoryboard(name:"Main",bundle:nil).instantiateViewController(withIdentifier: "AddTodoViewController") as! AddTodoViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
       
            
    }
    func  getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    private func setup() {
        
        cellHeights = Array(repeating: kCloseCellHeight, count: kRowsCount)
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
      
       
       
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         self.listTodo.removeAll()
        self.listTodoDeleted.removeAll()
        
        self.listTodo = accessTodo.getAllTodos()
        
        var i = 0
        for todo in listTodo {
           
            if(todo.isdeleted == "true"){
                self.listTodoDeleted.append(todo)
              
                self.listTodo.remove(at: i)
            }else{
            i = i+1
            }
        }
        self.tableView.reloadData()
        UINavigationBar.appearance().barTintColor = UIColor(red: 198/255, green: 218/255, blue: 2/255, alpha: 1.0)
    }
   
   
    
 }


// MARK: - TableView
extension TodoTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(listTodo.count > 0 && listTodoDeleted.count > 0){
        return 2
        }else if (listTodo.count > 0 || listTodoDeleted.count > 0){
            return 1
        }
        return 1
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(listTodo.count == 0 && listTodoDeleted.count == 0){
            return 1
        }
        if(listTodo.count > 0 && listTodoDeleted.count > 0){
        if(section == 0){
            return listTodo.count
        }else{
            return listTodoDeleted.count
            }
            
            
        }else if (listTodo.count > 0){
            return listTodo.count
        }else{
            return listTodoDeleted.count
        }
     
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as TodoCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.selectedAnimation(false, animated: false, completion:nil)
        } else {
            cell.selectedAnimation(true, animated: false, completion: nil)
        }
        
     
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       var view : UIView = UIView()

       
        if(self.listTodoDeleted.count == 0 && self.listTodo.count == 0){
            return view
        }
            
            view = UIView(frame: CGRect(x:0,y:0,width:tableView.frame.size.width,height:18))
            let label : UILabel = UILabel(frame : CGRect(x:10, y:5 , width:tableView.frame.size.width ,height: 18))
            label.font = UIFont.boldSystemFont(ofSize: 12)
            label.textColor = UIColor.white
            var string : String = ""
        if(tableView.numberOfSections == 2){
            string  = "Current"
            view.backgroundColor = UIColor(red: 198/255, green: 218/255, blue: 2/255, alpha: 0.6)
            if(section == 1){
                
                string = "Completed"
                view.backgroundColor = UIColor(red: 245/255, green: 82/255, blue: 45/255, alpha: 0.6)
            }
        }else{
            if(listTodo.count > 0){
                string  = "Current"
                view.backgroundColor = UIColor(red: 198/255, green: 218/255, blue: 2/255, alpha: 0.6)
                
            }else{
                string = "Completed"
                view.backgroundColor = UIColor(red: 245/255, green: 82/255, blue: 45/255, alpha: 0.6)
            }
        }
            label.text = string
            view.addSubview(label)
        
        
        
       
        return view
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (self.listTodo.count == 0 && self.listTodoDeleted.count == 0) {
            let cellEmpty = tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath)
            return cellEmpty
        
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! TodoCell
         var todo = Todo()
        if(tableView.numberOfSections == 2){
        if(indexPath.section == 0){
            todo = self.listTodo[indexPath.row]
            cell.checkedImageView.isHidden = true
            cell.doneButton.tag = 100+indexPath.row
          
        }else{
            todo = self.listTodoDeleted[indexPath.row]
            cell.checkedImageView.isHidden = false
            cell.doneButton.tag = 200 + indexPath.row
            cell.doneButton.setTitle("Delete", for: .normal )
            
        }
        }else{
            if(self.listTodo.count > 0){
                todo = self.listTodo[indexPath.row]
                cell.checkedImageView.isHidden = true
                cell.doneButton.tag = 100+indexPath.row
            }else{
                todo = self.listTodoDeleted[indexPath.row]
                cell.checkedImageView.isHidden = false
                cell.doneButton.tag = 200 + indexPath.row
                cell.doneButton.setTitle("Delete", for: .normal )
            }
        }
        
    
       
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
       // cell.closeNumberLabel.text = todo.category?.name
        cell.navigationController = self.navigationController!
       
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        cell.nameLabel.text = todo.name
        cell.nameExtendedLabel.text = todo.name
        cell.dateLabel.text = todo.date
        //cell.dateBegin.text = todo.date
        cell.dateEnd.text = todo.date
        cell.timeLabel.text = todo.time
        
        cell.leftView.backgroundColor = Utils.parseColor(string: (todo.category?.color)!)
        cell.barView.backgroundColor = Utils.parseColor(string: (todo.category?.color)!)
        cell.categoryMiniatureColor.backgroundColor = Utils.parseColor(string: (todo.category?.color)!)
        cell.categoryName.text = todo.category?.name
        cell.categoryExtendedName.text = todo.category?.name
        cell.timeExtendedLabel.text = todo.time
        cell.doneButton.addTarget(self, action: #selector(doneAction(sender:)), for: .touchUpInside)
        
        cell.todo = todo
        return cell
    }
    @objc func doneAction(sender: UIButton)  {
        if(sender.tag >= 100 && sender.tag < 200){
            let index = sender.tag-100
            self.listTodoDeleted.append(self.listTodo[index])
            self.listTodo[index].isdeleted = "true"
            
            self.listTodo.remove(at: index)
            do {
                try self.getContext().save()
                print("updated todo!")
                
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            tableView.reloadData()
        }else{
            let index = sender.tag-200
         
            self.accessTodo.deleteTodo(todo: self.listTodoDeleted[index])
            self.listTodoDeleted.remove(at: index)
            self.tableView.reloadData()
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   
        return cellHeights[indexPath.row]
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let complete = UITableViewRowAction(style: .normal, title: "Complete") { (action, indexPath) in
            self.listTodoDeleted.append(self.listTodo[indexPath.row])
            self.listTodo[indexPath.row].isdeleted = "true"
            
            self.listTodo.remove(at: indexPath.row)
            do {
                try self.getContext().save()
                print("updated todo!")
                
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            tableView.reloadData()
        }
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
         
           
            self.accessTodo.deleteTodo(todo: self.listTodoDeleted[indexPath.row])
            self.listTodoDeleted.remove(at: indexPath.row)
            
            
            tableView.reloadData()
        }
        let deleteTask = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            
            self.accessTodo.deleteTodo(todo: self.listTodo[indexPath.row])
            self.listTodo.remove(at: indexPath.row)
           
            tableView.reloadData()
        }
        
        
            if(tableView.numberOfSections == 2){
                if(indexPath.section == 0)
                {
                complete.backgroundColor = Utils.parseColor(string: (self.listTodo[indexPath.row].category?.color)!)
                      return [complete,deleteTask]
                }else{
                    delete.backgroundColor = Utils.parseColor(string: (self.listTodoDeleted[indexPath.row].category?.color)!)
                    return [delete]
                }
            }else {
                if(listTodo.count > 0){
                    complete.backgroundColor = Utils.parseColor(string: (self.listTodo[indexPath.row].category?.color)!)
                    return [complete,deleteTask]
                }else{
                    delete.backgroundColor = Utils.parseColor(string: (self.listTodoDeleted[indexPath.row].category?.color)!)
                    return [delete]
                }
            }
        
        
        
     
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(self.listTodo.count == 0 && self.listTodoDeleted.count == 0){
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC : AddTodoViewController = storyboard.instantiateViewController(withIdentifier: "AddTodoViewController") as! AddTodoViewController
            self.navigationController?.pushViewController(destinationVC, animated: true)
            return
        }
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
    }
    
}

 
