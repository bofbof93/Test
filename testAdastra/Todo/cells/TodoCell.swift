//
//  TodoCell.swift
//  testAdastra
//
//  Created by boufaied youssef on 03/11/2017.
//  Copyright © 2017 boufaied youssef. All rights reserved.
//

import UIKit
import FoldingCell

class TodoCell: FoldingCell {
  
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var categoryName: UILabel!
    @IBOutlet var categoryExtendedName: UILabel!
    @IBOutlet var duration: UILabel!
    @IBOutlet var dateEnd: UILabel!
    @IBOutlet var dateBegin: UILabel!
    @IBOutlet var nameExtendedLabel: UILabel!
    @IBOutlet var barView: UIView!
    @IBOutlet var categoryMiniatureColor: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var leftView: UIView!
    @IBOutlet weak var closeNumberLabel: UILabel!
    @IBOutlet var timeExtendedLabel: UILabel!
    var todo:Todo = Todo()
    var navigationController : UINavigationController = UINavigationController()
    @IBOutlet var checkedImageView: UIImageView!
    
  var number: Int = 0 {
    didSet {
      closeNumberLabel.text = String(number)
      
    }
  }
  
  override func awakeFromNib() {
    foregroundView.layer.cornerRadius = 10
    foregroundView.layer.masksToBounds = true
    super.awakeFromNib()
  }
  
  override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
    let durations = [0.26, 0.2, 0.2]
    return durations[itemIndex]
  }
  
    @IBAction func editAction(_ sender: Any) {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destination : AddTodoViewController = storyboard.instantiateViewController(withIdentifier: "AddTodoViewController") as! AddTodoViewController
      //  destination.todo = todo
        destination.name = todo.name!
        destination.category = (todo.category?.name)!
        destination.fromEdit = true
        destination.date = todo.dateComplete!
        destination.objectID = todo.objectID
        self.navigationController.pushViewController(destination, animated: true)
        
    }
}

// MARK: - Actions ⚡️
extension TodoCell {
  
  @IBAction func buttonHandler(_ sender: AnyObject) {
    print("tap")
    
  }
  
}
