//
//  HabitViewNewVer.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/30.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class HabitViewNewVer: UIView {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    class func instance() -> HabitViewNewVer {
        return UINib(nibName: "HabitViewNewVer", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! HabitViewNewVer
    }
    

}
