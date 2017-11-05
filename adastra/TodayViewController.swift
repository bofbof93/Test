//
//  TodayViewController.swift
//  adastra
//
//  Created by boufaied youssef on 05/11/2017.
//  Copyright © 2017 boufaied youssef. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreData
class TodayViewController: UIViewController, NCWidgetProviding {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
