//
//  AddCategoryViewController.swift
//  testAdastra
//
//  Created by boufaied youssef on 03/11/2017.
//  Copyright © 2017 boufaied youssef. All rights reserved.
//

import UIKit
import CoreData
import PopupDialog
class AddCategoryViewController: UIViewController {

    @IBOutlet var sliderColor: UISlider!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var colorPalletteImage: UIImageView!
    @IBOutlet var colorView: UIView!
    func  getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.view.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    @IBAction func sliderChanger(_ sender: Any) {
        self.colorView.backgroundColor =  Utils.sliderToColor(value: Int(sliderColor.value))
        sliderColor.tintColor = Utils.sliderToColor(value: Int(sliderColor.value))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func doneAction(_ sender: Any) {
        if(self.nameTextField.text != ""){
             let category = Category(entity: NSEntityDescription.entity(forEntityName: "Category", in: self.getContext())!, insertInto: self.getContext())
        category.name = self.nameTextField.text
        //category.color = self.colorView.backgroundColor
        let colors : [CGFloat] = (self.colorView.backgroundColor?.cgColor.components)!
        
        
        category.color = "\(colors[0]*255),\(colors[1]*255),\(colors[2]*255)"
        do {
            try self.getContext().save()
            print("saved Todo!")
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
