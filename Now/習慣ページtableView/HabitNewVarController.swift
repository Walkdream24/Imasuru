//
//  HabitNewVarController.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/30.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class HabitNewVarController: UIViewController {
    
    let habitView = HabitViewNewVer.instance()
    override func viewDidLoad() {
        super.viewDidLoad()
        habitView.frame = self.view.frame
        self.view.addSubview(habitView)
        habitView.tableView.delegate = self
        habitView.tableView.dataSource = self
        habitView.tableView.register(UINib(nibName: "HabitNameTableViewCell", bundle: nil), forCellReuseIdentifier: "HabitNameTableViewCell")
        habitView.tableView.register(UINib(nibName: "HabitCircleTableViewCell", bundle: nil), forCellReuseIdentifier: "HabitCircleTableViewCell")
        habitView.tableView.register(UINib(nibName: "RemainLifeTableViewCell", bundle: nil), forCellReuseIdentifier: "RemainLifeTableViewCell")
    }

}
extension HabitNewVarController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HabitNameTableViewCell") as! HabitNameTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCircleTableViewCell") as! HabitCircleTableViewCell
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "RemainLifeTableViewCell") as! RemainLifeTableViewCell
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 135
        case 1:
            return 312
        default :
            return 99
            
        }
    }
}
