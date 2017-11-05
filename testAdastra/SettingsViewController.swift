//
//  SettingsViewController.swift
//  testAdastra
//
//  Created by boufaied youssef on 03/11/2017.
//  Copyright © 2017 boufaied youssef. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var switchNotification: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        switchNotification.onTintColor = UIColor(red: 198/255, green: 218/255, blue: 2/255, alpha: 1.0)
        if(UserDefaults.standard.bool(forKey: "NotifEnabled")){
            switchNotification.isOn = true
        }else{
            switchNotification.isOn = false
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        
        if(switchNotification.isOn){
            UserDefaults.standard.set(true, forKey: "NotifEnabled")
        }else{
            UserDefaults.standard.set(false, forKey: "NotifEnabled")
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
