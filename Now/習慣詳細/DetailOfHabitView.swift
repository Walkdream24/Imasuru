//
//  DetailOfHabitView.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/07.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift

class DetailOfHabitView: UIView {
    @IBOutlet weak var tableView: UITableView!
    class func instance() -> DetailOfHabitView {
        return UINib(nibName: "DetailOfHabitView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as!  DetailOfHabitView
    }
   
   

}
