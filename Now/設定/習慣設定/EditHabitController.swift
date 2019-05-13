//
//  EditHabitController.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/12.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class EditHabitController: UIViewController {
    let editHabitView = EditHabitView.instance()
    let tableSection = ["", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editHabitView.frame = self.view.frame
        self.view.addSubview(editHabitView)
        editHabitView.tableView.delegate = self
        editHabitView.tableView.dataSource = self
        editHabitView.tableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
        editHabitView.tableView.register(UINib(nibName: "EditTableViewCell", bundle: nil), forCellReuseIdentifier: "EditTableViewCell")
        editHabitView.tableView.register(UINib(nibName: "CreateNewHabitTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateNewHabitTableViewCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}
extension EditHabitController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return tableSection.count
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell") as! EmptyTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditTableViewCell") as! EditTableViewCell
            cell.configNameLabel.text = "通知時間"
           
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateNewHabitTableViewCell") as! CreateNewHabitTableViewCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 10
        case 1:
            return 61
        default:
            return 61
            
        }
    }
    
    
}
