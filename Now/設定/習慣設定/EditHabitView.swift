//
//  EditHabitView.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/12.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift

class EditHabitView: UIView {
    @IBOutlet weak var tableView: UITableView!
    class func instance() -> EditHabitView {
        return UINib(nibName: "EditHabitView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! EditHabitView
    }
    
  
    
    
 

}
